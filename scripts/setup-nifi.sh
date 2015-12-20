#!/bin/bash

source "/vagrant/scripts/common.sh"

function installLocalNifi {
	echo "install nifi from local file"
	FILE=/vagrant/resources/${NIFI_ARCHIVE}
	tar -xzf $FILE -C /usr/local
}

function installRemoteNifi {
	echo "install nifi from remote file"
	curl -o /vagrant/resources/${NIFI_ARCHIVE} -O -L ${NIFI_MIRROR_DOWNLOAD}
	tar -xzf /vagrant/resources/${NIFI_ARCHIVE} -C /usr/local
}

function setupNifi {
	echo "copying over nifi configuration files"
#	cp -f ${NIFI_RES_DIR}/flume-env.sh ${NIFI_CONF}/flume-env.sh
}

function setupEnvVars {
	echo "creating nifi environment variables"
	cp -f ${NIFI_RES_DIR}/nifi.sh /etc/profile.d/nifi.sh
	cp -f ${NIFI_RES_DIR}/nifi.properties ${NIFI_HOME}/conf/nifi.properties
}

function installNifi {
	if resourceExists ${NIFI_ARCHIVE}; then
		installLocalNifi
	else
		installRemoteNifi
	fi
	ln -s /usr/local/nifi-${NIFI_VERSION} /usr/local/nifi
}

echo "setup nifi"
installNifi
setupNifi
setupEnvVars