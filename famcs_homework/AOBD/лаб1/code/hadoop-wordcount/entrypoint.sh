#!/bin/bash
set -e

if [ ! -d "/opt/hadoop/data/nameNode/current" ]; then
  echo "формат namenode (первый запуск)"
  hdfs namenode -format -force -nonInteractive
fi

hdfs --daemon start namenode
hdfs --daemon start datanode
yarn --daemon start resourcemanager
yarn --daemon start nodemanager

tail -f /dev/null
