#!/bin/bash

#java
JAVA_VERSION="8"
JAVA_UPDATE="91"
JAVA_ARCHIVE=jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
JAVA_HOME="jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}"

#hadoop
HADOOP_PREFIX=/usr/local/hadoop
HADOOP_CONF_DIR=$HADOOP_PREFIX/etc/hadoop
HADOOP_VERSION=2.7.3
HADOOP_ARCHIVE=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/${HADOOP_ARCHIVE}
HADOOP_RES_DIR=/vagrant/resources/hadoop

#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

#Kafka
KAFKA_VERSION=0.8.2.2
KAFKA_NAME=kafka_2.10-${KAFKA_VERSION}
KAFKA_ARCHIVE=${KAFKA_NAME}.tgz
KAFKA_MIRROR_DOWNLOAD=http://www.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_ARCHIVE}
KAFKA_RES_DIR=/vagrant/resources/kafka
KAFKA_HOME=/usr/local/kafka
KAFKA_CONF=${KAFKA_HOME}/conf

#Cassandra
CASSANDRA_VERSION=2.1.10
CASSANDRA_NAME=apache-cassandra-${CASSANDRA_VERSION}-bin
CASSANDRA_ARCHIVE=${CASSANDRA_NAME}.tar.gz
CASSANDRA_MIRROR_DOWNLOAD=http://www.apache.org/dist/cassandra/${CASSANDRA_VERSION}/${CASSANDRA_ARCHIVE}
CASSANDRA_RES_DIR=/vagrant/resources/cassandra
CASSANDRA_HOME=/usr/local/cassandra
CASSANDRA_CONF=${CASSANDRA_HOME}/conf

#Nifi
NIFI_VERSION=1.3.0
NIFI_NAME=nifi-${NIFI_VERSION}
NIFI_ARCHIVE=${NIFI_NAME}-bin.tar.gz
NIFI_MIRROR_DOWNLOAD=http://www.apache.org/dist/nifi/${NIFI_VERSION}/${NIFI_ARCHIVE}
NIFI_RES_DIR=/vagrant/resources/nifi
NIFI_HOME=/usr/local/nifi
NIFI_CONF=$NIFI_HOME/config


function resourceExists {
	FILE=/vagrant/resources/$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

function fileExists {
	FILE=$1
	if [ -e $FILE ]
	then
		return 0
	else
		return 1
	fi
}

#echo "common loaded"
