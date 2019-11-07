#!/bin/bash
source "/vagrant/scripts/common.sh"

function installRemoteJava {
	echo "install open jdk"
	yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel
	ln -s /usr/lib/jvm/jre /usr/local/java
}

function setupEnvVars {
	echo "creating java environment variables"
	echo JAVA_HOME=/usr/local/java >> /etc/default/java
}

echo "setup java"
installRemoteJava
setupEnvVars
