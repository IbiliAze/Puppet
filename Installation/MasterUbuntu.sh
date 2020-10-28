#!/bin/bash


echo step 1
wget https://apt.puppetlabs.com/puppet6-release-bionic.deb

echo step 2
sudo dpkg -i puppet6-release-bionic.deb

echo step 3
sudo apt update

echo step 4
rm puppet6-release-bionic.deb

echo step 5
sudo echo "127.0.0.1        localhost ubuntu puppet" >> /etc/hosts

echo step 6
sudo apt install puppetserver

echo step 7
cd /etc/puppetlabs/puppet

echo step 8
sudo echo '''# This file can be used to override the default puppet settings.
# See the following links for more details on what settings are available:
# - https://puppet.com/docs/puppet/latest/config_important_settings.html
# - https://puppet.com/docs/puppet/latest/config_about_settings.html
# - https://puppet.com/docs/puppet/latest/config_file_main.html
# - https://puppet.com/docs/puppet/latest/configuration.html
[main]
certname = ubuntu

[server]
certname = ubuntu
vardir = /opt/puppetlabs/server/data/puppetserver
logdir = /var/log/puppetlabs/puppetserver
rundir = /var/run/puppetlabs/puppetserver
pidfile = /var/run/puppetlabs/puppetserver/puppetserver.pid
codedir = /etc/puppetlabs/code''' > puppet.conf

echo step 9
sudo echo '''###########################################
# Init settings for puppetserver
###########################################

# Location of your Java binary (version 8)
JAVA_BIN="/usr/bin/java"

# Modify this if youd like to change the memory allocation, enable JMX, etc
JAVA_ARGS="-Xms512m -Xmx512m -Djruby.logger.class=com.puppetlabs.jruby_utils.jruby.Slf4jLogger"

# Modify this as you would JAVA_ARGS but for non-service related subcommands
JAVA_ARGS_CLI="${JAVA_ARGS_CLI:-}"

# Modify this if youd like TrapperKeeper specific arguments
TK_ARGS=""

# These normally shouldnt need to be edited if using OS packages
USER="puppet"
GROUP="puppet"
INSTALL_DIR="/opt/puppetlabs/server/apps/puppetserver"
CONFIG="/etc/puppetlabs/puppetserver/conf.d"

# Bootstrap path
BOOTSTRAP_CONFIG="/etc/puppetlabs/puppetserver/services.d/,/opt/puppetlabs/server/apps/puppetserver/config/services.d/"

# SERVICE_STOP_RETRIES can be set here to alter the default stop timeout in
# seconds.  For systemd, the shorter of this setting or TimeoutStopSec in
# the systemd.service definition will effectively be the timeout which is used.
SERVICE_STOP_RETRIES=60

# START_TIMEOUT can be set here to alter the default startup timeout in
# seconds.  For systemd, the shorter of this setting or TimeoutStartSec
# in the services systemd.service configuration file will effectively be the
# timeout which is used.
START_TIMEOUT=300


# Maximum number of seconds that can expire for a service reload attempt before
# the result of the attempt is interpreted as a failure.
RELOAD_TIMEOUT=120''' > /etc/default/puppetserver

echo step 10
sudo /opt/puppetlabs/bin/puppetserver ca setup

echo step 11
sudo systemctl start puppetserver.service

echo step 12
sudo systemctl enable puppetserver.service

echo step 13
sudo systemctl status puppetserver.service

echo step 14
cd -

echo step 15
bash

echo step 16
logout

echo step 17
puppetserver ca list



