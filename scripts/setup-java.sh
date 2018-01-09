#!/bin/bash
source "/vagrant/scripts/common.sh"

function installLocalJava {
	echo "installing oracle jdk"
	FILE=/vagrant/resources/$JAVA_ARCHIVE
	tar -xzf $FILE -C /usr/local
}

function installRemoteJava {
	echo "install open jdk"
	yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel
}

function setupJava {
	echo "setting up java"
	if resourceExists $JAVA_ARCHIVE; then
                chown -R root:root /usr/local/${JAVA_HOME}
		ln -s /usr/local/${JAVA_HOME} /usr/local/java
	else
		ln -s /usr/lib/jvm/jre /usr/local/java
	fi
}

function setupEnvVars {
	echo "creating java environment variables"
	echo JAVA_HOME=/usr/local/java >> /etc/default/java
}

function installJava {
	if resourceExists $JAVA_ARCHIVE; then
		installLocalJava
	else
		installRemoteJava
	fi
}

echo "setup java"
installJava
setupJava
setupEnvVars
