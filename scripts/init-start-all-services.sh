#!/bin/bash
source "/vagrant/scripts/common.sh"

function formatNameNode {
	/usr/local/hadoop/bin/hdfs namenode -format myhadoop -force -noninteractive
	echo "formatted namenode"
}

function startServices {

  # Start HDFS
	systemctl start hdfs-namenode.service
	systemctl start hdfs-datanode.service

  # Start kafka
	systemctl start zookeeper.service
  systemctl start kafka.service

  # Start nifi
	systemctl start nifi

	# Start nifi-registry
	systemctl start nifi-registry
}

function createEventLogDir {
	/usr/local/hadoop/bin/hdfs dfs -mkdir /tmp
	echo "created tmp dir"
}

function setupServices {
  # Refresh services
	systemctl daemon-reload

	# Enable services
	systemctl enable hdfs-namenode.service
	systemctl enable hdfs-datanode.service
	systemctl enable zookeeper.service
	systemctl enable kafka.service
	systemctl enable nifi
	systemctl enable nifi-registry
}

setupServices
formatNameNode
startServices
createEventLogDir
