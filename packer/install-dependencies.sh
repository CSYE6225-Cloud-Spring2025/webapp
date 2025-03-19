#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# install Node.js and npm packages
sudo apt install nodejs -y
sudo apt install npm -y