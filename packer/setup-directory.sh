#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# install node modules
sudo mkdir /opt/csye6225
cd /opt/csye6225/webapp || exit
sudo npm install