# Welcome to LAMP on AWS!

The examples in this folder contains instructions to quickly install LAMP stack on AWS Linux 2 and configure TLS. 
## Steps
###  Create AWS Linux2 Instance usng this as cloud init  
- https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it
###  Configure Apache 
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/configure-apache.sh
- bash configure-apache.sh
###  Configure TLS
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/configure-tls.sh
- bash configure-tls.sh
###  Secure the database server
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/secure-db.sh
- bash secure-db.sh
### Install  and configure phpMyAdmin
[phyMyAdmin](https://www.phpmyadmin.net/) is a web-based database management tool that you can use to view and edit the MySQL databases on your EC2 instance
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/phpAdmin-install-config.sh
- bash phpAdmin-install-config.sh

> Note of thanks. This README.md was edited using https://stackedit.io/app#. 
