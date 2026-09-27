import org.apache.spark.{SparkConf, SparkContext}

object PageRank {
  def main(args: Array[String]): Unit = {
    val inputPath = args(0)
    val outputPath = args(1)
    val numVertices = args(2).toInt
    val iterations = args(3).toInt

    val conf = new SparkConf().setAppName("PageRank")
    val sc = new SparkContext(conf)
    sc.setLogLevel("WARN")

    // рёбра графа: строка "откуда\tкуда" -> пара (src, dst)
    val edges = sc.textFile(inputPath).map { line =>
      val parts = line.split("\t")
      (parts(0).toInt, parts(1).toInt)
    }

    val allVertices = sc.parallelize(0 until numVertices)

    val verticesWithNoOutgoing = allVertices.map(v => (v, Iterable.empty[Int])) // каждой вершине - пустой список исходящих рёбер
    val groupedEdges = edges.groupByKey() // группируем рёбра по вершине-источнику: (вершина, список тех, на кого она ссылается)
    val links = verticesWithNoOutgoing.union(groupedEdges) // объединяем - теперь у каждой вершины есть запись (пустая или с рёбрами)
      .reduceByKey(_ ++ _) // если для вершины есть и пустая, и реальная запись - склеиваем их в одну
      .persist() // держит в памяти, чтобы не пересчитывать links заново на каждой итерации

    var ranks = links.mapValues(_ => 1.0) // изначально у всех вершин одинаковый ранг

    for (_ <- 1 to iterations) {
      val linksWithRanks = links.join(ranks) // сводим вместе для каждой вершины её список ссылок и её текущий ранг
      val contributions = linksWithRanks.flatMap { case (_, (dests, rank)) =>
        // вершина отдаёт свой ранг поровну всем, на кого ссылается
        if (dests.isEmpty) Iterable.empty else dests.map(dest => (dest, rank / dests.size))
      }
      val received = contributions.reduceByKey(_ + _) // складываем все вклады, пришедшие на каждую вершину

      val verticesWithZero = allVertices.map(v => (v, 0.0)) // вершины без входящих ссылок не попадут в received - поэтому всем сначала даём 0.0
      ranks = verticesWithZero.union(received)
        .reduceByKey(_ + _) // если для вершины есть и 0.0, и реальный вклад - складываем (0 ничего не меняет)
        .mapValues(sum => 0.15 + 0.85 * sum) // формула PageRank с коэффициентом затухания 0.85
    }

    ranks.sortBy(_._2, ascending = false).saveAsTextFile(outputPath)
    sc.stop()
  }
}
