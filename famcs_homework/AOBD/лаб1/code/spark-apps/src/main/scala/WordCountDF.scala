import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._

object WordCountDF {
  def main(args: Array[String]): Unit = {
    val inputPath = args(0)
    val outputPath = args(1)

    val spark = SparkSession.builder().appName("WordCountDF").getOrCreate()
    spark.sparkContext.setLogLevel("WARN")

    val lines = spark.read.text(inputPath)  // читаем файл - одна колонка value, в ней целая строка файла
    val splitWords = split(col("value"), "\\s+")  // split разбивает строку на массив слов
    val words = lines.select(explode(splitWords).as("word"))  // explode разворачивает массив в отдельные строки - одно слово на строку
    val grouped = words.groupBy("word")  // группируем строки по слову
    val counts = grouped.count()  // считаем размер каждой группы - количество вхождений слова

    counts.write.mode("overwrite").csv(outputPath)
    spark.stop()
  }
}
