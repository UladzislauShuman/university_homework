FROM eclipse-temurin:8-jdk-jammy

ENV HADOOP_VERSION=3.3.6
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV JAVA_HOME=/opt/java/openjdk

RUN apt-get update && apt-get install -y --no-install-recommends curl ssh && rm -rf /var/lib/apt/lists/*

COPY hadoop-${HADOOP_VERSION}.tar.gz /tmp/hadoop.tar.gz
RUN tar -xzf /tmp/hadoop.tar.gz -C /opt \
    && mv /opt/hadoop-${HADOOP_VERSION} $HADOOP_HOME \
    && rm /tmp/hadoop.tar.gz

COPY config/*.xml $HADOOP_CONF_DIR/
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && mkdir -p /opt/hadoop/data/nameNode /opt/hadoop/data/dataNode

WORKDIR /opt/hadoop

CMD ["/entrypoint.sh"]
