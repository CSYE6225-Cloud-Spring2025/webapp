#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# create group and new user
sudo groupadd "$APP_GROUP"
sudo useradd --system -m -g "$APP_GROUP" -s /usr/sbin/nologin "$APP_USER"

# provide app folder permissions to the user and group
sudo chown -R "$APP_USER":"$APP_GROUP" /opt/csye6225
sudo chmod -R 750 /opt/csye6225

# provide log folder permissions to the user and group
sudo chown -R "$APP_USER":"$APP_GROUP" /var/log/nodejs
sudo chmod -R 750 /var/log/nodejs

# provide cloudwatch config folder permissions to the user and group
sudo chown -R "$APP_USER":"$APP_GROUP" /opt/aws/amazon-cloudwatch-agent/etc/
sudo chmod -R 750 /opt/aws/amazon-cloudwatch-agent/etc/