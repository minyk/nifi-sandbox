#!/usr/bin/env bash

source /etc/profile.d/kafka.sh

EXEC_PATH=${KAFKA_HOME}/bin
CONF_DIR=${KAFKA_HOME}/config
ZOOKEEPER_EXEC_PATH=${EXEC_PATH}/zookeeper-server-start.sh
KAFKA_EXEC_PATH=${EXEC_PATH}/kafka-server-start.sh

/bin/bash -c "nohup nice -n 0 \
      $ZOOKEEPER_EXEC_PATH $CONF_DIR/zookeeper.properties \
      > $ZK_LOG_FILE 2>&1 &"'echo $!' > $ZK_PID_FILE

/bin/bash -c "nohup nice -n 0 \
      $KAFKA_EXEC_PATH $CONF_DIR/server.properties \
      > $KAFKA_LOG_FILE 2>&1 &"'echo $!' > $KAFKA_PID_FILE
