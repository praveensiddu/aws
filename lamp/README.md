# Welcome to LAMP on AWS!

The examples in this folder contains instructions to quickly [install LAMP stack on AWS Linux 2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-lamp-amazon-linux-2.html) and configure TLS. 
## Steps
###  Create AWS Linux2 Instance usng this as cloud init  
- https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it
- if you are routing all traffic through a proxy(Bastion) then you need only ssh from bastion in security group. Else open both http and https in security group.
###  Configure Apache 
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/configure-apache.sh
- bash configure-apache.sh
- test http://yourdomain or http://publicIP
###  Configure self signed TLS
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/configure-tls.sh
- bash configure-tls.sh
- look at https://github.com/praveensiddu/aws/tree/main/bastion#configure-tls for cert signed by lets encrypt
###  Secure the database server
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/secure-db.sh
- bash secure-db.sh
  - Set root password? [Y/n] Y
  - New password:
  - Re-enter new password:
  - Remove anonymous users? [Y/n] Y
  - Disallow root login remotely? [Y/n] Y
  - Remove test database and access to it? [Y/n] Y
  - Reload privilege tables now? [Y/n] Y

### Install  and configure phpMyAdmin
[phyMyAdmin](https://www.phpmyadmin.net/) is a web-based database management tool that you can use to view and edit the MySQL databases on your EC2 instance
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/phpAdmin-install-config.sh
- bash phpAdmin-install-config.sh
- access phpAdmin page http://yourdomain/phpMyAdmin/ and make you you can login as admin
- http://yourdomain/phpMyAdmin/setup click on download to do any further configuration
> Note of thanks. This README.md was edited using https://stackedit.io/app#. 
