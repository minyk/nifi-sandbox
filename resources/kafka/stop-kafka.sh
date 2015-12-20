#!/usr/bin/env bash

source /etc/profile.d/kafka.sh

kill -TERM `cat $KAFKA_PID_FILE`
kill -TERM `cat $ZK_PID_FILE`
