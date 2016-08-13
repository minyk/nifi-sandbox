#!/bin/bash

#java
JAVA_VERSION="8"
JAVA_UPDATE="91"
JAVA_ARCHIVE=jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz
JAVA_HOME="jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}"

#ssh
SSH_RES_DIR=/vagrant/resources/ssh
RES_SSH_COPYID_ORIGINAL=$SSH_RES_DIR/ssh-copy-id.original
RES_SSH_COPYID_MODIFIED=$SSH_RES_DIR/ssh-copy-id.modified
RES_SSH_CONFIG=$SSH_RES_DIR/config

#Nifi
NIFI_VERSION=1.0.0-BETA
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
