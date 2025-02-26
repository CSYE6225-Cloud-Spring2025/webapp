#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

echo "Contents of /tmp/webapp before copy"
ls -la /tmp/webapp
sudo mkdir -p /opt/csye6225/webapp
sudo cp -R /tmp/webapp/* /opt/csye6225/webapp/
echo "Contents of opt/csye6225/webapp after copy"
ls -la /opt/csye6225/webapp

# create environment variable file
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
