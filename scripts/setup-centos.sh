#!/bin/bash
source "/vagrant/scripts/common.sh"

function disableFirewall {
	echo "disabling firewall"
	systemctl stop firewalld
  systemctl disable firewalld
}

echo "setup centos"

disableFirewall
