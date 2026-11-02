import java.sql.Timestamp

import scala.collection.concurrent.TrieMap

import org.apache.spark.sql.{DataFrame, SparkSession}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.streaming.{GroupState, GroupStateTimeout, OutputMode, StreamingQueryListener, Trigger}
import org.apache.spark.sql.types.{LongType, StringType, StructType}

// одно событие из kafka после разбора json
case class Event(user_id: String, event_type: String, event_time: Timestamp, produce_ts: Long)

// результат подсчёта: сколько событий было у пользователя за конкретную минуту
case class MinuteCount(user_id: String, minute_start: Timestamp, count: Long)

// после каждого микро-батча spark сообщает статистику - собираем из неё нужное
class ProgressCollector extends StreamingQueryListener {
  val droppedByWatermark = TrieMap.empty[String, Long] // сколько событий отброшено как опоздавшие
  val rows = TrieMap.empty[String, Long]               // сколько событий всего обработано
  val batches = TrieMap.empty[String, Long]            // сколько было микро-батчей
  val batchMs = TrieMap.empty[String, Long]            // суммарное время всех микро-батчей

  override def onQueryStarted(event: StreamingQueryListener.QueryStartedEvent): Unit = {}
  override def onQueryTerminated(event: StreamingQueryListener.QueryTerminatedEvent): Unit = {}

  override def onQueryProgress(event: StreamingQueryListener.QueryProgressEvent): Unit = {
    val p = event.progress
    val name = p.name
    val dropped = p.stateOperators.map(_.numRowsDroppedByWatermark).sum
    droppedByWatermark.put(name, droppedByWatermark.getOrElse(name, 0L) + dropped)
    if (p.numInputRows > 0) {
      rows.put(name, rows.getOrElse(name, 0L) + p.numInputRows)
      batches.put(name, batches.getOrElse(name, 0L) + 1)
      batchMs.put(name, batchMs.getOrElse(name, 0L) + p.batchDuration)
    }
  }
}

object StreamApp {
  def main(args: Array[String]): Unit = {
    val mode = args(0)                 // windows / state / latency
    val durationSec = args(1).toInt    // сколько секунд работать, потом остановиться
    val startingOffsets = if (args.length > 2) args(2) else "latest" // latest - только новые события, earliest - всё, что лежит в топике

    val spark = SparkSession.builder()
      .appName(s"StreamApp-$mode")
      .config("spark.sql.shuffle.partitions", "4") // на сколько частей делить данные при группировке
      .getOrCreate()
    spark.sparkContext.setLogLevel("WARN")
    import spark.implicits._

    val progress = new ProgressCollector
    spark.streams.addListener(progress)

    // своя папка под каждый запуск - тут spark хранит, докуда дочитал и промежуточное состояние окон
    val checkpointRoot = s"/workspace/checkpoints/spark-$mode-${System.currentTimeMillis()}"

    // поток из kafka: каждая запись - key, value (байты), topic, partition, offset, timestamp
    val kafkaStream = spark.readStream
      .format("kafka")
      .option("kafka.bootstrap.servers", "kafka:29092") // внутренний вход брокера в docker-сети
      .option("subscribe", "events")                    // из какого топика читать
      .option("startingOffsets", startingOffsets)
      .load()

    val schema = new StructType()
      .add("user_id", StringType)
      .add("event_type", StringType)
      .add("event_time", LongType)
      .add("produce_ts", LongType)

    val jsonStrings = kafkaStream.selectExpr("CAST(value AS STRING) AS json") // value - байты, переводим в строку
    val parsed = jsonStrings.select(from_json($"json", schema).as("e"))       // разбираем json по схеме
    val flat = parsed.select("e.*")                                            // разворачиваем поля в отдельные колонки
    val events = flat.withColumn("event_time", expr("timestamp_millis(event_time)")) // миллисекунды -> полноценное время

    // ждёт опоздавшие события ещё 10 с после самого свежего event_time,
    // всё, что старше - отбрасывается
    val watermarked = events.withWatermark("event_time", "10 seconds")

    // печать результата каждого микро-батча, если в нём что-то есть
    // сортировать поток нельзя, а вот готовый батч - уже обычная таблица, его можно
    def printQuery(name: String, df: DataFrame, sortBy: String*): Unit = {
      val printBatch: (DataFrame, Long) => Unit = (batch, batchId) => {
        if (!batch.isEmpty) {
          StreamApp.synchronized { // так как запросы работают параллельно, чтобы заголовок и таблица не перемешались с чужими
            println(s"=== $name, batch $batchId")
            batch.orderBy(sortBy.map(col): _*).show(100, truncate = false)
          }
        }
      }
      df.writeStream
        .queryName(name)
        .outputMode("append")                         // выдавать окно один раз
        .trigger(Trigger.ProcessingTime("10 seconds")) // батч раз в 10 с
        .option("checkpointLocation", s"$checkpointRoot/$name")
        .foreachBatch(printBatch)
        .start()
    }

    // окном у нас будут две читаемые колонки с началом и концом
    def withWindowBounds(df: DataFrame, windowCol: String): DataFrame =
      df.select(
        date_format(col(s"$windowCol.start"), "HH:mm:ss").as("start"),
        date_format(col(s"$windowCol.end"), "HH:mm:ss").as("end"),
        $"user_id",
        $"count"
      )

    mode match {
      case "windows" =>
        // tumbling: окна по 1 минуте подряд, без пересечений
        val tumblingGrouped = watermarked.groupBy(window($"event_time", "1 minute"), $"user_id")
        val tumbling = tumblingGrouped.count()
        printQuery("tumbling", withWindowBounds(tumbling, "window"), "start", "user_id")

        // sliding: окно 1 минута, новое начинается каждые 20 с - окна пересекаются
        val slidingGrouped = watermarked.groupBy(window($"event_time", "1 minute", "20 seconds"), $"user_id")
        val sliding = slidingGrouped.count()
        printQuery("sliding", withWindowBounds(sliding, "window"), "start", "user_id")

        // session
        val sessionGrouped = watermarked.groupBy(session_window($"event_time", "15 seconds"), $"user_id")
        val session = sessionGrouped.count()
        printQuery("session", withWindowBounds(session, "session_window"), "start", "user_id")

      case "state" =>
        val typed = watermarked.as[Event]            // строки -> объекты Event
        val byUser = typed.groupByKey(_.user_id)     // ключ - пользователь, у каждого своё состояние
        val minuteCounts = byUser.flatMapGroupsWithState(
          OutputMode.Append,                         // каждую минуту выдаём один раз, когда она закрыта
          GroupStateTimeout.EventTimeTimeout         // будильник срабатывает по водяной метке, а не по часам
        )(countPerMinute)
        val readable = minuteCounts.select(
          $"user_id",
          date_format($"minute_start", "HH:mm").as("minute"),
          $"count"
        )
        printQuery("state", readable, "minute", "user_id")

      case "latency" =>
        val out = flat.select(
          $"user_id".as("key"),
          to_json(struct($"user_id", $"event_type", $"event_time", $"produce_ts")).as("value")
        )
        out.writeStream
          .queryName("latency")
          .format("kafka")
          .option("kafka.bootstrap.servers", "kafka:29092")
          .option("topic", "spark-latency")
          .option("checkpointLocation", s"$checkpointRoot/latency")
          .start() // следующий микро-батч стартует сразу после предыдущего
    }

    spark.streams.awaitAnyTermination(durationSec * 1000L)
    spark.streams.active.foreach(_.stop())

    // итоговая статистика по каждому запросу
    for (name <- progress.batches.keys.toSeq.sorted) {
      val b = progress.batches(name)
      println(s"[$name] rows=${progress.rows(name)} batches=$b avg_batch_ms=${progress.batchMs(name) / b} " +
        s"dropped_by_watermark=${progress.droppedByWatermark.getOrElse(name, 0L)}")
    }
    spark.stop()
  }

  // состояние пользователя это минута -> сколько событий в ней
  def countPerMinute(user: String, events: Iterator[Event], state: GroupState[Map[Long, Long]]): Iterator[MinuteCount] = {
    val watermark = state.getCurrentWatermarkMs() // до какого момента считаем, что всё уже пришло
    var counts = state.getOption.getOrElse(Map.empty[Long, Long])

    for (e <- events) {
      val ts = e.event_time.getTime
      val minuteStart = ts - ts % 60000 // начало минуты, в которую попало событие
      if (minuteStart + 60000 > watermark)
        counts = counts.updated(minuteStart, counts.getOrElse(minuteStart, 0L) + 1)
    }

    // закрытые минуты - отдаём, открытые - оставляем в состоянии
    val (finished, open) = counts.partition { case (minute, _) => minute + 60000 <= watermark }

    if (open.isEmpty) {
      state.remove() // у пользователя ничего не копится - состояние больше не нужно
    } else {
      state.update(open)
      state.setTimeoutTimestamp(open.keys.min + 60000) // разбудить, когда закроется ближайшая минута
    }

    finished.toSeq.sortBy(_._1).map { case (minute, c) => MinuteCount(user, new Timestamp(minute), c) }.iterator
  }
}
