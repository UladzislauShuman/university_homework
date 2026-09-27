import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.rdd.RDD

object PartitioningExperiment {
  def main(args: Array[String]): Unit = {
    val inputPath = args(0)
    val mode = args(1) // "scan" - перебор чисел партиций, "repartition-coalesce" - сравнение repartition/coalesce, "persist" - с кэшем и без

    val conf = new SparkConf().setAppName("PartitioningExperiment")
    val sc = new SparkContext(conf)
    sc.setLogLevel("WARN")

    // запускает wordcount над готовым rdd и возвращает время выполнения в мс
    def timeIt(lines: RDD[String]): Long = {
      val start = System.currentTimeMillis()
      lines.flatMap(_.split("\\s+")).map(w => (w, 1)).reduceByKey(_ + _).count() // action - без неё вычисление не запустится
      System.currentTimeMillis() - start
    }

    timeIt(sc.textFile(inputPath)) // прогрев - тот же пайплайн один раз до замеров

    mode match {
      case "scan" =>
        // список чисел партиций для перебора; если не передали - берём значения по умолчанию
        val partitionCounts = if (args.length > 2) args(2).split(",").map(_.toInt) else Array(1, 2, 4, 8, 16, 32, 128)
        for (n <- partitionCounts) {
          val lines = sc.textFile(inputPath, n) // n - минимальное число партиций при чтении файла
          println(s"partitions=$n actual=${lines.getNumPartitions} time_ms=${timeIt(lines)}")
        }

      case "repartition-coalesce" =>
        // список целевых чисел партиций для repartition/coalesce; если не передали - берём значения по умолчанию
        val targets = if (args.length > 2) args(2).split(",").map(_.toInt) else Array(1, 2, 4, 8, 16)

        // repartition/coalesce меняют число партиций уже после чтения файла, а не при самом чтении
        val base = sc.textFile(inputPath) // естественное разбиение, без minPartitions
        println(s"base actual=${base.getNumPartitions} time_ms=${timeIt(base)}")

        for (n <- targets) {
          val repartitioned = base.repartition(n)
          println(s"repartition($n) actual=${repartitioned.getNumPartitions} time_ms=${timeIt(repartitioned)}")

          val coalesced = base.coalesce(n)
          println(s"coalesce($n) actual=${coalesced.getNumPartitions} time_ms=${timeIt(coalesced)}")
        }

      case "persist" =>
        def timeAction(words: RDD[String]): Long = {
          val start = System.currentTimeMillis()
          words.count()
          System.currentTimeMillis() - start
        }
        // специально медленная операция на каждое слово, чтобы пересчёт был заметно дороже кэша
        def words(): RDD[String] = sc.textFile(inputPath).flatMap(_.split("\\s+")).map { w =>
          var h = w.hashCode
          for (i <- 0 until 500) h = h * 31 + i
          w
        }

        val notCached = words()
        println(s"no_cache run1_ms=${timeAction(notCached)} run2_ms=${timeAction(notCached)}")

        val cached = words().persist()
        println(s"with_cache run1_ms=${timeAction(cached)} run2_ms=${timeAction(cached)}")
    }

    sc.stop()
  }
}
