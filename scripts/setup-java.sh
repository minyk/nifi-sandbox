#!/bin/bash
source "/vagrant/scripts/common.sh"

function installRemoteJava {
	echo "install open jdk 21"
	yum install -y java-21-openjdk java-21-openjdk-devel
	ln -s $(dirname $(dirname $(readlink -f $(which java)))) /usr/local/java
}

function setupEnvVars {
	echo "creating java environment variables"
	echo JAVA_HOME=/usr/local/java >> /etc/default/java
}

echo "setup java"
installRemoteJava
setupEnvVars
