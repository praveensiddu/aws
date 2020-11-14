# Creating a Bastion host on AWS
This page contains instructions to create a bastion host in AWS with these goals
 1. Only Bastion host is accessible via SSH
--  This should be improved further to allow access only from known IP's
--  Automatically configure the security group with the IP you are using to connect
-- All other servers are internal and not accessible via SSH
 5. Configure Mobaxterm to be able to access other servers via Bastion
 6. List item

## Steps
###  Create AWS Linux2 Instance usng this as cloud init  
- https://raw.githubusercontent.com/praveensiddu/aws/main/bastion/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it

> Note of thanks. This README.md was edited using https://stackedit.io/app#. 

