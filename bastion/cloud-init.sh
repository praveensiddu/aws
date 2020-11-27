#!/bin/bash
sudo yum update -y
sudo yum install tree -y
sudo yum install docker -y
sudo yum install jq -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo systemctl enable docker
sudo systemctl start docker
cd /etc/haproxy
sudo cp haproxy.cfg haproxy.cfg.orig
sudo rm haproxy.cfg
sudo wget https://raw.githubusercontent.com/praveensiddu/aws/main/bastion/haproxy.cfg
sudo yum install haproxy -y
echo "set -o vi" >> ~/.bashrc
sudo bash -c 'echo set -o vi >> ~root/.bashrc'

mkdir ~/keys
