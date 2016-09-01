#!/bin/bash
#
#       /etc/rc.d/init.d/<servicename>
#
#       <description of the *service*>
#       <any general comments about this init script>
#
# <tags -- see below for tag definitions.  *Every line* from the top
#  of the file to the end of the tags section must begin with a #
#  character.  After the tags section, there should be a blank line.
#  This keeps normal comments in the rest of the file from being
#  mistaken for tags, should they happen to fit the pattern.>

# Source function library.
### BEGIN INIT INFO
# Provides: iptables
# Required-Start:
# Required-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start and stop hadoop/kafka/nifi
# Description: Start, stop hadoop/kafka/nifi
### END INIT INFO

. /etc/init.d/functions

source /etc/profile.d/java.sh
source /etc/profile.d/hadoop.sh
source /etc/profile.d/kafka.sh
source /etc/profile.d/nifi.sh

SVC_USER="root"
EXEC="runuser -s /bin/bash ${SVC_USER} -c "

function start_hdfs() {
	$EXEC "$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs start namenode"
	$EXEC "$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs start datanode"
	echo "started hdfs"
}

function stop_hdfs() {
	$EXEC "$HADOOP_PREFIX/sbin/hadoop-daemon.sh --config $HADOOP_CONF_DIR --script hdfs stop namenode"
	$EXEC "$HADOOP_PREFIX/sbin/hadoop-daemons.sh --config $HADOOP_CONF_DIR --script hdfs stop datanode"
	echo "stopped hdfs"
}

function start_yarn() {
	$EXEC "$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager"
	$EXEC "$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR start nodemanager"
	$EXEC "$HADOOP_YARN_HOME/sbin/yarn-daemon.sh start proxyserver --config $HADOOP_CONF_DIR"
	$EXEC "$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver --config $HADOOP_CONF_DIR"
	echo "started yarn"
}

function stop_yarn() {
	$EXEC "$HADOOP_YARN_HOME/sbin/yarn-daemon.sh --config $HADOOP_CONF_DIR stop resourcemanager"
	$EXEC "$HADOOP_YARN_HOME/sbin/yarn-daemons.sh --config $HADOOP_CONF_DIR stop nodemanager"
	$EXEC "$HADOOP_YARN_HOME/sbin/yarn-daemon.sh stop proxyserver --config $HADOOP_CONF_DIR"
	$EXEC "$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh stop historyserver --config $HADOOP_CONF_DIR"
	echo "stopped yarn"
}

function start_kafka {
    $EXEC "$KAFKA_HOME/start-kafka.sh"
}

function stop_kafka {
    $EXEC "$KAFKA_HOME/stop-kafka.sh"
}

function start_nifi {
    $EXEC "$NIFI_HOME/bin/nifi.sh start"
}

function stop_nifi {
    $EXEC "$NIFI_HOME/bin/nifi.sh stop"
}

start() {
    start_hdfs
    #start_yarn
    start_kafka
    start_nifi
	return 0
}

stop() {
    stop_kafka
    #stop_yarn
    stop_hdfs
    stop_nifi
	return 0
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
        echo "Usage: start-all-services {start|stop}"
        exit 1
        ;;
esac
exit $?
