Sandbox for Apache nifi
================================

# Introduction

Vagrant project to spin up a cluster of 1 virtual machine with Hadoop 2.7.1, Kafka 0.8.2.2 and Nifi 1.2.0

* [Hadoop](http://hadoop.apache.org)
* [Kafka](http://kafka.apache.org)
* [Nifi](http://nifi.apache.org)

# Getting Started

1. [Download and install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Download and install Vagrant](http://www.vagrantup.com/downloads.html).
3. Run ```vagrant box add centos/7```
4. Git clone this project, and change directory (cd) into this project (directory).
5. Run ```vagrant up``` to create the VM.
6. Run ```vagrant ssh``` to get into your VM.
7. Run ```vagrant destroy``` when you want to destroy and get rid of the VM.

Some gotcha's.

1. Make sure you download Vagrant v1.4.3 or higher.
2. Make sure when you clone this project, you preserve the Unix/OSX end-of-line (EOL) characters. The scripts will fail with Windows EOL characters.
3. Make sure you have 4Gb of free memory for the VM. You may change the Vagrantfile to specify smaller memory requirements.
4. This project has NOT been tested with the VMWare provider for Vagrant.
5. You may change the script (common.sh) to point to a different location for Hadoop, Kafka and Nifi to be downloaded from. Here is a list of mirrors for Hadoop: http://www.apache.org/dyn/closer.cgi/hadoop/common/.
6. Basically, Hadoop YARN is installed, but not started. If you want YARN Service, uncomment YARN section of `scripts/init-start-all-services.sh` and `scripts/start-all-services.sh`.

# Advanced Stuff

-If you have the resources (CPU + Disk Space + Memory), you may modify Vagrantfile to have even more HDFS DataNodes, YARN NodeManagers. Just find the line that says "numNodes = 4" in Vagrantfile and increase that number. The scripts should dynamically provision the additional slaves for you.-

# How to Change Stack Versions

Edit variables in `scripts/common.sh`.

## OS

`nifi-sandbox` uses CentOS 6.8 for default. It can be changed to other version/distribution. Just edit the `Vagrantfile`'s following lines:

```
    node.vm.box = "centos/7"
```

## java

Default settings use `jdk-8u91-linux-x64.tar.gz` or `java-1.8.0-openjdk.x86_64`. Edit following lines from `scripts/common.sh` for oracle JDK:

```
#java
JAVA_ARCHIVE=jdk-8u91-linux-x64.tar.gz
```

In case of OpenJDK, edit `scripts/setup-java.sh`:

```bash
function installRemoteJava {
	echo "install open jdk"
	yum install -y java-1.8.0-openjdk.x86_64
}
```

## hadoop

Hadoop version is described in `scripts/common.sh`:

```bash
HADOOP_VERSION=2.7.1
HADOOP_ARCHIVE=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_MIRROR_DOWNLOAD=http://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/${HADOOP_ARCHIVE}
```

To build the sandbox, Make sure `HADOOP_MIRROR_DOWNLOAD` is available for downloading.

## Kafka

Kafka version is described in `scripts/common.sh`

```bash
#Kafka
KAFKA_VERSION=0.8.2.2
KAFKA_NAME=kafka_2.10-${KAFKA_VERSION}
KAFKA_ARCHIVE=${KAFKA_NAME}.tgz
KAFKA_MIRROR_DOWNLOAD=http://www.apache.org/dist/kafka/${KAFKA_VERSION}/${KAFKA_ARCHIVE}
KAFKA_RES_DIR=/vagrant/resources/kafka
KAFKA_HOME=/usr/local/kafka
KAFKA_CONF=${KAFKA_HOME}/conf
```

## Nifi

Nifi version is described in `scripts/common.sh`

```bash
#Nifi
NIFI_VERSION=1.2.0
NIFI_NAME=nifi-${NIFI_VERSION}
NIFI_ARCHIVE=${NIFI_NAME}-bin.tar.gz
NIFI_MIRROR_DOWNLOAD=http://www.apache.org/dist/${NIFI_VERSION}/${NIFI_ARCHIVE}
NIFI_RES_DIR=/vagrant/resources/nifi
NIFI_HOME=/usr/local/nifi
NIFI_CONF=$NIFI_HOME/config
```

# Make the VMs setup faster
You can make the VM setup even faster if you pre-download the Hadoop, Kafka and Oracle JDK into the `/resources` directory.

1. `/resources/hadoop-2.7.1.tar.gz`
3. `/resources/jdk-8u91-linux-x64.gz`
4. `/resources/kafka_2.10-0.8.2.2.tgz`
5. `/resources/nifi-1.2.0-bin.tar.gz`

The setup script will automatically detect if these files (with precisely the same names) exist and use them instead. If you are using slightly different versions, you will have to modify the script accordingly.

# Web UI
You can check the following URLs to monitor the Hadoop daemons.

1. [NameNode] (http://10.10.10.101:50070/dfshealth.html)
2. [Nifi] (http://10.10.10.101:8888/nifi)

# Vagrant box location
The Vagrant box is downloaded to the `~/.vagrant.d/boxes` directory. On Windows, this is `C:/Users/{your-username}/.vagrant.d/boxes`.

# Acknowledgements

This project is started from Jee Vang's [vagrant-hadoop-2.4.1-spark-1.0.1](https://github.com/vangj/vagrant-hadoop-2.4.1-spark-1.0.1). Thanks a lot.

# License
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
