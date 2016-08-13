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
# Short-Description: start and stop hadoop/spark
# Description: Start, stop hadoop/spark
### END INIT INFO

. /etc/init.d/functions

source /etc/profile.d/java.sh
source /etc/profile.d/nifi.sh

SVC_USER="root"
EXEC="runuser -s /bin/bash ${SVC_USER} -c "

function start_nifi {
    $EXEC "$NIFI_HOME/bin/nifi.sh start"
}

function stop_nifi {
    $EXEC "$NIFI_HOME/bin/nifi.sh stop"
}

start() {
    start_nifi
	return 0
}

stop() {
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
