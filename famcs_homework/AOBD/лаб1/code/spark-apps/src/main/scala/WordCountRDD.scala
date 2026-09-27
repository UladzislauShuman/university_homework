import org.apache.spark.{SparkConf, SparkContext}

object WordCountRDD {
  def main(args: Array[String]): Unit = {
    val inputPath = args(0)
    val outputPath = args(1)

    val conf = new SparkConf().setAppName("WordCountRDD") // настройки приложения
    val sc = new SparkContext(conf)
    sc.setLogLevel("WARN")

    val lines = sc.textFile(inputPath)          // читаем файл - каждая строка становится отдельным элементом
    val words = lines.flatMap(_.split("\\s+"))  // разбиваем каждую строку на слова
    val pairs = words.map(word => (word, 1))    // каждому слову ставим в пару 1
    val counts = pairs.reduceByKey(_ + _)       // складываем значения с одинаковым словом (_ + _ - сложение двух чисел)

    counts.saveAsTextFile(outputPath)
    sc.stop()
  }
}
