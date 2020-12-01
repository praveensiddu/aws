# Welcome to K3s in AWS
This page contains instructions to run K3s in AWS and deploy a sample application nginx. 

## Create Ubuntu instance using this as cloud init
Either create using CLI or manually on the UI.
- Make sure bastion host is configured for programmatic access https://github.com/praveensiddu/aws/tree/main/bastion#configure-programatic-access
- Find your keypair name that you use to SSH from bastion here https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs:
### Create instance using CLI
Create Ubuntu instance
- Set environment varaible to the SSH key name used to SSH from bastion
export MYSSHKEYNAME=aws-swift-bastion-praveen
- rm -f create-instance.sh && wget https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/create-instance.sh
- bash create-instance.sh
### Create instance using GUI
- Create Ubuntu instance on UI with 
  - SSH key name used to SSH from bastion
  - with this link as userdata https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it
- if you are routing all traffic through a proxy(Bastion or load balancer) then you need only ssh from bastion in security group. Else open both http and https in security group.

## Install K3S
- ssh from bastion to the new host. Example ssh ubuntu@172.31.56.44
- Install K3s by running "curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644"
## Deploy NGINX to test
- kubectl apply -f https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx_deployment.yaml
- kubectl apply -f https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx_service.yaml
- kubectl apply -f https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx_ingress.yaml
- Verify your deployment
  - kubectl get pods
  - run curl localhost:80
  - kubectl delete deployment nginx
  - curl localhost:80
    - It should display "Service Unavailable"
  - kubectl apply -f https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx_deployment.yaml
  - curl localhost:80




