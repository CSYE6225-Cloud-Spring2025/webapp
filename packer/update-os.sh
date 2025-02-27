#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# fetch and upgrade system packages
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get clean

sudo mkdir -p /tmp/webapp
sudo chmod 666 /tmp/webapp