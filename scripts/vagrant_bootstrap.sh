#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

#TODO remove
sudo route del default gw 10.0.2.2
sudo route add default gw 192.168.0.1

# Install dependencies
sudo apt-get -y update
sudo apt-get install -y python-pip libpython-dev libffi-dev libssl-dev

# Install Python modules
sudo pip install ansible boto

# Copy to home directory to prevent key file permission issues on Windows hosts
cp -r /vagrant ~/automate

echo '---------------------------------------------------------------------'
echo .
echo The environment should be ready to use. To enter use \"vagrant ssh\"
echo .
echo Now you will need to export AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
echo then run:
echo .
echo '     ~/automate/scripts/provision.sh'
echo .
echo '---------------------------------------------------------------------'

