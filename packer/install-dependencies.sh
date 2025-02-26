#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# install and start the MySQL database server
sudo apt-get install mysql-server -y

# start mysql server
sudo systemctl enable mysql
sudo systemctl start mysql

# create password for root user and create webapp database
sudo mysql -e "ALTER USER '$DB_USER'@'$DB_HOST' IDENTIFIED WITH mysql_native_password BY '$DB_PASSWORD'; FLUSH PRIVILEGES;"
sudo mysql -u root -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# install Node.js and npm packages
sudo apt install nodejs -y
sudo apt install npm -y

# copy the source code into opt/csye6225
sudo mkdir /opt/csye6225
sudo cp -r /tmp/webapp /opt/csye6225/