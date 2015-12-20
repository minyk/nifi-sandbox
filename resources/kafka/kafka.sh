export KAFKA_HOME=/usr/local/kafka
export PATH=${KAFKA_HOME}/bin:${PATH}

export LOG_DIR=${KAFKA_HOME}/logs
export ZK_LOG_FILE=${LOG_DIR}/zookeeper.log
export KAFKA_LOG_FILE=${LOG_DIR}/kafka.log

export ZK_PID_FILE=${KAFKA_HOME}/zookeeper.pid
export KAFKA_PID_FILE=${KAFKA_HOME}/kafka.pid