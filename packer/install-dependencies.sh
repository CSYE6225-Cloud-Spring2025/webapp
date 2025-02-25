#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
export CHECKPOINT_DISABLE=1

# install and start the MySQL database server
sudo apt install mysql-server -y

# create password for root user and create webapp database
sudo mysql -e "ALTER USER '$DB_USER'@'$DB_HOST' IDENTIFIED WITH mysql_native_password BY '$DB_PASSWORD'; FLUSH PRIVILEGES;"
sudo mysql -u root -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# install Node.js and npm packages
sudo apt install nodejs -y
sudo apt install npm -y