#!/bin/bash
source "/vagrant/scripts/common.sh"
source /etc/profile.d/java.sh
source /etc/profile.d/nifi.sh
source /etc/profile.d/nifi-toolkit.sh

function startNifi {
    $NIFI_HOME/bin/nifi.sh start

}

function setupServices {
    cp -f /vagrant/scripts/start-all-services.sh /etc/init.d/start-all-services
    chmod a+x /etc/init.d/start-all-services
    chkconfig start-all-services on
}

startNifi
setupServices
