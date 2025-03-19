#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# copy from /tmp/opt/webapp to /opt/csye6225/webapp
sudo mkdir -p /opt/csye6225/webapp
sudo chmod -R 755 /opt/csye6225/webapp
sudo cp -R /tmp/webapp/* /opt/csye6225/webapp/

# install node modules
cd /opt/csye6225/webapp || exit
sudo npm install
