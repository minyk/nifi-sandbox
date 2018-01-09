#!/bin/bash

source "/vagrant/scripts/common.sh"

function installLocalNifiRegistry {
	echo "install Nifi Registry from local file"
	FILE=/vagrant/resources/${NIFI_REGISTRY_ARCHIVE}
	tar -xzf $FILE -C /usr/local
}

function installRemoteNifiRegistry {
	echo "install Nifi Registry from remote file"
	curl -o /vagrant/resources/${NIFI_REGISTRY_ARCHIVE} -O -L ${NIFI_REGISTRY_MIRROR_DOWNLOAD}
	tar -xzf /vagrant/resources/${NIFI_REGISTRY_ARCHIVE} -C /usr/local
}

function setupNifiRegistry {
	echo "install Nifi Registry service"
	${NIFI_REGISTRY_HOME}/bin/nifi-registry.sh install
}

function setupEnvVars {
	echo "creating Nifi Registry environment variables"
	cp -f ${NIFI_REGISTRY_RES_DIR}/${NIFI_REGISTRY_NAME}.properties ${NIFI_REGISTRY_HOME}/conf/nifi-registry.properties
	cp -f ${NIFI_RES_DIR}/nifi-registry-env.sh ${NIFI_REGISTRY_HOME}/bin/nifi-registry-env.sh
}

function installNifiRegistry {
	if resourceExists ${NIFI_REGISTRY_ARCHIVE}; then
		installLocalNifiRegistry
	else
		installRemoteNifiRegistry
	fi
	ln -s /usr/local/nifi-registry-${NIFI_REGISTRY_VERSION} ${NIFI_REGISTRY_HOME}
}

echo "setup nifi registry"
installNifiRegistry
setupNifiRegistry
setupEnvVars
