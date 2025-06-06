## Assignment 1
1. Go to root and run `npm install`
2. Create database.env file and for DB_HOST, DB_USER, DB_PASSWORD, DB_NAME credentials
3. Run `node server.js` from the root

## Assignment 2
- To run unit tests after setup: `npm test /opt/csye6225/webapp/tests/healthz.test.js`
- Select a 1GB memory droplet not the lowest one
1. Create a .env file for the DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, PORT, APP_GROUP, APP_USER credentials
2. Put both the `install.sh` and `.env` file in the same directory as webapp
3. scp `.env`, `webapp.zip`, and `script.sh` to server using `scp -i ~/.ssh/digital-ocean-key .env. webapp.zip install.sh root@<host-ip>:/opt`
4. ssh into the server using `ssh -i ~/.ssh/digital-ocean-key root@<host-ip>`
5. Give executable permsiion to the root user using `chmod +x /opt/install.sh` and run `/opt/install.sh`
6. `su - <demouser>` to change into the created user for testing

## Assignment 4
1. Configure all secrets and variables and GitHub as seen in packer-builder.yml
2. Merge PR to trigger AWS and GCP machine image builds
3. For `GCP` setup the Firewall policy to allow traffic on application port and create a <network-tag>
4. Start instance creation and select the custom image shared from the dev account
5. Configure the <network-tag> in the instance's target tag
6. Finally create the instance and get its public ipv4 address to send requests

## Assignment 8
1. Configure the `demo` account credentials in GitHub secrets along with template and auto-scaling group names
2. Create the infrastructure using `terraform apply` in demo account
3. Merge a PR to trigger the auto-scaling group refresh with latest AMI