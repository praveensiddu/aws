# Welcome to LAMP on AWS!

The examples in this folder contains instructions to quickly install LAMP stack on AWS Linux 2 and configure TLS. 
## Steps
###  Create AWS Instance usng this as cloud init  
- https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/cloud-init.sh
###  Configure Apache 
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/configure-apache.sh
- bash configure-apache.sh
###  Configure TLS
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/configure-tls.sh
- bash configure-tls.sh
###  Secure the database server
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/secure-db
- bash secure-db.sh
