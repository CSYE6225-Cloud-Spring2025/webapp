#!/bin/bash

source /opt/.env

# fetch and upgrade system packages
apt update
apt-get upgrade -y

# install and start the MySQL database server
apt install mysql-server -y

# create password for root user and create webapp database
mysql -e "ALTER USER '$DB_USER'@'$DB_HOST' IDENTIFIED WITH mysql_native_password BY '$DB_PASSWORD'; FLUSH PRIVILEGES";
mysql -u root -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# install Node.js and npm packages
apt install nodejs -y
apt install npm -y

# install unzip and decompress the zip
mkdir /opt/csye6225
apt install unzip -y
unzip /opt/webapp.zip -d /opt/csye6225

# install node modules
cd /opt/csye6225/webapp || exit
npm install

# create group and new user
groupadd demogroup
useradd -m -g demogroup -s /bin/bash demouser

# provide permissions to the user and group
chown -R "$APP_USER":"$APP_GROUP" /opt/csye6225
chmod -R 750 /opt/csye6225

# move the environment variables file to webapp
mv /opt/.env /opt/csye6225/webapp