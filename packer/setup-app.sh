#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# copy the service file to systemd directory
sudo cp /opt/csye6225/webapp/packer/webapp.service /etc/systemd/system/webapp.service

# copy the cloudwatch agent config file to aws directory
sudo cp /opt/csye6225/webapp/config/cloud-watch.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# configure run on system boot
sudo systemctl daemon-reload
sudo systemctl enable webapp
sudo systemctl enable amazon-cloudwatch-agent