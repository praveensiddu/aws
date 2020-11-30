# Creating a Bastion host on AWS
This page contains instructions to create a bastion host in AWS.

## Concept
Bastion hosts (also called “jump servers”) are often used as a best practice for accessing privately accessible hosts within a system environment. For example, your system might include an application host that is not intended to be publicly accessible. To access it for product updates or managing system patches, you typically log in to a bastion host and then access (or “jump to”) the application host from there. 
Access to the bastion host is ideally restricted to a specific IP range, typically from your organization’s corporate network or IP assigned to your home router by ISP. The benefit of using a bastion host in this regard is that access to any of the internal hosts is isolated to one means of access: through either a single bastion host or a group. For further isolation, the bastion host generally resides in a separate VPC.

## Goals
1. Only Bastion host is accessible from internet via SSH
  - This should be improved further to allow access only from known IP's
  - Automatically configure the bastion security group allowed source IP's with the IP you are using to connect after 2FA check.
  - All other servers must be internal and SSH access should be limited to Bastion host.
2. Configure Mobaxterm to be able to access other internal hosts via Bastion
  - Edit Session->Network Settings->
  - Remote Host=internal host ip, username internal host username. In connect through ssh gateway use bastion settings


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
We would be launching insstances using this bastion host. So enable programatic access from Bastion host and remove it when you are done.
- Create a non root user in IAM( since root account must not be used for programatic access). Assign AdministratorAccess privilege to the user( Ideally only limited privilege must be given)
- Login as that IAM user. "Create access key" and download from here https://console.aws.amazon.com/iam/home?region=us-east-1#/security_credentials
- Run "aws configure" on bastion host.
  - AWS Access Key ID [None]: 
  - AWS Secret Access Key [None]: 
  - Default region name [None]: us-east-1

### Configure public IP
It is recommended to reserve an elastic IP in AWS and assign it to bastion host. This will help so that you don't need to change IP each time you restart Bastion. You can configure your domain and mobaxterm with this static IP your own.

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


> Note of thanks. This README.md was edited using   