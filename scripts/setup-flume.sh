#!/bin/bash

source "/vagrant/scripts/common.sh"

function installLocalFlume {
	echo "install flume from local file"
	FILE=/vagrant/resources/${FLUME_ARCHIVE}
	tar -xzf $FILE -C /usr/local
}

function installRemoteFlume {
	echo "install flume from remote file"
	curl -o /vagrant/resources/${FLUME_ARCHIVE} -O -L ${FLUME_MIRROR_DOWNLOAD}
	tar -xzf /vagrant/resources/${FLUME_ARCHIVE} -C /usr/local
}

function setupFlume {
    echo "prepare plugins directory"
    mkdir -p ${FLUME_HOME}/plugins.d

	echo "copying over flume configuration files"
	cp -f ${FLUME_RES_DIR}/flume-env.sh ${FLUME_CONF}/flume-env.sh
}

function setupEnvVars {
	echo "creating flume environment variables"
	cp -f ${FLUME_RES_DIR}/flume.sh /etc/profile.d/flume.sh
}

function installFlume {
	if resourceExists ${FLUME_ARCHIVE}; then
		installLocalFlume
	else
		installRemoteFlume
	fi
	ln -s /usr/local/apache-flume-${FLUME_VERSION}-bin /usr/local/flume
}

echo "setup flume"
installFlume
setupFlume
setupEnvVars