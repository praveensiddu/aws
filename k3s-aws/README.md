# Welcome to Tomcat on K3s in AWS
This page contains instructions to run a tomcat container on K3s in AWS.

## Create Ubuntu instance usng this as cloud init
Either create using CLI or manually on the UI.
- Make sure bastion host is configured for programmatic access https://github.com/praveensiddu/aws/tree/main/bastion#configure-programatic-access
- Find your keypair name that you use to SSH from bastion here https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs:
### Using CLI
- Set environment varaible to the SSH key name used to SSH from bastion
export MYSSHKEYNAME=aws-swift-bastion-praveen
- rm -f create-instance.sh && wget https://raw.githubusercontent.com/praveensiddu/aws/main/tomcat-on-k3s/create-instance.sh
- bash create-instance.sh
### Using GUI
- Create Ubuntu instance with 
  - SSH key name used to SSH from bastion
  - https://raw.githubusercontent.com/praveensiddu/aws/main/tomcat-on-k3s/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it
- if you are routing all traffic through a proxy(Bastion or load balancer) then you need only ssh from bastion in security group. Else open both http and https in security group.

## Install K3S
- ssh from bastion to the new host
- curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
## Deploy NGINX to test
- kubectl apply -f https://raw.githubusercontent.com/myannou/k3d-demo/master/nginx.yaml
- kubectl get pods
