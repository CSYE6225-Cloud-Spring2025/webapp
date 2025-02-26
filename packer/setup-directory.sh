#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# copy from /tmp/opt/webapp to /opt/csye6225/webapp
sudo mkdir -p /opt/csye6225/webapp
sudo chmod -R 755 /opt/csye6225/webapp
sudo cp -R /tmp/webapp/* /opt/csye6225/webapp/

# create environment variable file
sudo touch /opt/csye6225/webapp/.env
sudo chmod 666 /opt/csye6225/webapp/.env
{
  echo "DB_HOST=${DB_HOST}"
  echo "DB_USER=${DB_USER}"
  echo "DB_PASSWORD=${DB_PASSWORD}"
  echo "DB_NAME=${DB_NAME}"
  echo "PORT=${PORT}"
} > "/opt/csye6225/webapp/.env"

# install node modules
cd /opt/csye6225/webapp || exit
sudo npm install
