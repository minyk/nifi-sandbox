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
	echo "install Nifi service"
	${NIFI_HOME}/bin/nifi.sh install
}

function setupEnvVars {
	echo "creating nifi environment variables"
	#cp -f ${NIFI_RES_DIR}/${NIFI_NAME}.properties ${NIFI_HOME}/conf/nifi.properties
	cp -f ${NIFI_RES_DIR}/nifi-env.sh ${NIFI_HOME}/bin/nifi-env.sh
}

function addNars {
	echo "adding /vagrant/nars to nifi.nar.library.directory"
	echo "" >> ${NIFI_HOME}/conf/nifi.properties
	echo "nifi.nar.library.directory.add=/vagrant/nars" >> ${NIFI_HOME}/conf/nifi.properties
	echo "" >> ${NIFI_HOME}/conf/nifi.properties
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
addNars
