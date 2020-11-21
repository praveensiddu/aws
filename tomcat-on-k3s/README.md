# Welcome to Tomcat on K3s in AWS

The examples in this folder contains instructions to quickly Install K3s and configure TLS. 
## Steps
###  Create Ubuntu instance usng this as cloud init  
- TBD Autoamte the creation of instance 
aws ec2 describe-images \
>     --owners 099720109477 \
>     --filters Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-* \
>     --query 'sort_by(Images,&CreationDate)[-1].ImageId'
"ami-022758574f5a26580"

- https://raw.githubusercontent.com/praveensiddu/aws/main/tomcat-on-k3s/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it
- if you are routing all traffic through a proxy(Bastion) then you need only ssh from bastion in security group. Else open both http and https in security group.

## Install K3S 
- curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

## Deploy tomcat container on K3s

https://stackoverflow.com/questions/54341432/deploy-war-in-tomcat-on-kubernetes

