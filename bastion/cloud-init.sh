#!/bin/bash
sudo yum update -y
sudo yum install tree -y
sudo yum install docker -y
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
