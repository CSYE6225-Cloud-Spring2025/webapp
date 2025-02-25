#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# copy the service file to systemd directory
sudo cp /tmp/webapp.service /etc/systemd/system/webapp.service

# configure run on system boot
sudo systemctl daemon-reload
sudo systemtl enable webapp