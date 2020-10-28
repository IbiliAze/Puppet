#!/bin/bash


echo step 1
sudo echo "192.168.0.64    ubuntu puppet" >> /etc/hosts

echo step 2
wget https://apt.puppetlabs.com/puppet5-release-wheezy.deb

echo step 3
sudo dpkg -i puppet5-release-wheezy.deb

echo step 4
sudo apt update -y

echo step 5
sudo apt install -y puppet-agent

echo step 6
sudo systemctl start puppet

echo step 7
sudo systemctl status puppet

echo step 8
sudo systemctl enable puppet

echo step 9
logout

echo step 10


