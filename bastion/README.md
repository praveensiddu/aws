# Creating a Bastion host on AWS
This page contains instructions to create a bastion host in AWS.
## Goals
1. Only Bastion host is accessible from internet via SSH
  - This should be improved further to allow access only from known IP's
  - Automatically configure the security group with the IP you are using to connect
  - All other servers must be internal and SSH access should be limited to Bastion host.
2. Configure Mobaxterm to be able to access other servers via Bastion

## Steps
### Create AWS Linux2 Instance usng this as cloud init
- https://raw.githubusercontent.com/praveensiddu/aws/main/bastion/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it
### Configure SSH keys
SSH access to all other hosts should go through Bastion. The private key to login to other hosts should be available only on Bastion. The public key should be used while creating the instances. Copy the private key to this location 
- Create any instance on aws on create fresh pair of keys. Recommed to have bastion in the key name
- Download the private key and then copy the private key to bastion host
- Login to the newly created instance and copy the public key file ~/.ssh/authorized_keys to your local laptop. You may need it in future.
- copy the private key you donwloaded on your laptop to bastion host.
  - cp yourprivatekey_onbastion.pem /home/ec2-user/.ssh/id_rsa
- chmod 0400 /home/ec2-user/.ssh/id_rsa
### Configure programatic access
We would be launching insstances using this bastion host. So enable programatic access and remove it each time 
- aws configure
  - AWS Access Key ID [None]: 
  - AWS Secret Access Key [None]: 
  - Default region name [None]: us-east-1

### HAProxy
- Make sure http and https ports are added to security group
- Install LAMP following the instructions in https://github.com/praveensiddu/aws/tree/main/lamp
- If you plan to run a haproxy as frontend to your apache server, define "apacheserver.local" in /etc/hosts with the IP address of the apache server. This name is used in haproxy backend configuration.
- systemctl start haproxy
- systemctl enable haproxy
### Configure TLS
- Below instructions were derived from [here](https://www.digitalocean.com/community/tutorials/how-to-secure-haproxy-with-let-s-encrypt-on-centos-7)
- Update **yourdomain** to point the bastion host public IP. If you don't have a domain [register a new one](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/registrar.html)
It is recommended to reserve an elastic IP in AWS and assign it to bastion host.
- Get new certs in /etc/haproxy/certs
  - wget https://raw.githubusercontent.com/praveensiddu/aws/main/bastion/get-cert-letsencrypt.sh
  - bash get-cert-letsencrypt.sh **yourdomain**
  - At the prompts enter the following
    - (Enter 'c' to cancel): ***youremailaddress.com***
    - (A)gree/(C)ancel: ***Y***
    - (Y)es/(N)o: Y
- sudo systemctl restart haproxy
- Make sure your backend apache server is running and open https://yourdomain and https://yourdomain/phpMyAdmin in your browzer to test it.


> Note of thanks. This README.md was edited using https://stackedit.io/app#.