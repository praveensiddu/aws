#!/bin/bash
sudo yum update -y
sudo yum install tree -y
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
wget 
#sudo yum install haproxy -y
echo "set -o vi" >> ~/.bashrc
sudo echo "set -o vi" >> ~root/.bashrc

mkdir ~/keys
