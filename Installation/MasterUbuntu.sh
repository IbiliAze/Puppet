#!/bin/bash


echo step 1
sudo apt install -y puppetserver

echo step 2
systemctl start puppetserver

