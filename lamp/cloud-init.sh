#!/bin/bash
sudo yum update -y
sudo yum install tree -yum
sudo yum install -y httpd24 php72 mysql57-server php72-mysqlnd
#Start the Apache web server.
sudo service httpd start
# start at each system boot
sudo chkconfig httpd on
sleep 1
# make sure httpd is running
chkconfig --list httpd
