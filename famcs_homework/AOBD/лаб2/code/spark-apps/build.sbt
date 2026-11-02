name := "spark-apps"
version := "1.0"
scalaVersion := "2.12.18"

// provided - эти библиотеки уже есть на кластере, в jar их упаковывать не нужно
// коннектор к kafka (spark-sql-kafka) подтягивается при запуске через --packages
libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-sql" % "3.5.3" % "provided"
)
