# Creating a Bastion host on AWS
This page contains instructions to create a bastion host in AWS.
## Goals
1. Only Bastion host is accessible via SSH
-- This should be improved further to allow access only from known IP's
-- Automatically configure the security group with the IP you are using to connect
-- All other servers are internal and not accessible via SSH
5. Configure Mobaxterm to be able to access other servers via Bastion
6. List item
## Steps
### Create AWS Linux2 Instance usng this as cloud init
- https://raw.githubusercontent.com/praveensiddu/aws/main/bastion/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it
### HAProxy
- Make sure http and https ports are added to security group
- Install LAMP following the instructions in https://github.com/praveensiddu/aws/tree/main/lamp
- If you plan to run a haproxy as frontend to your apache server, define apacheserver.local in /etc/hosts with the IP address of the apache server
- systemctl start haproxy
- systemctl enable haproxy
### Configure TLS
- Instructions were derived from [here](https://www.digitalocean.com/community/tutorials/how-to-secure-haproxy-with-let-s-encrypt-on-centos-7)
- Update **<yourdomain>** to point the bastion host public IP
- Get new certs in /etc/haproxy/certs
  - wget https://raw.githubusercontent.com/praveensiddu/aws/main/bastion/get-cert-letsencrypt.sh
  - bash get-cert-letsencrypt.sh **<yourdomain>**
  - At the prompts enter the following
    - (Enter 'c' to cancel): ***youremailaddress.com***
    - (A)gree/(C)ancel: ***Y***
    - (Y)es/(N)o: Y
- sudo systemctl restart haproxy
- open https://<yourdomain> in browzer


> Note of thanks. This README.md was edited using https://stackedit.io/app#.