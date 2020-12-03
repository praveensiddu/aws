# Welcome to K3s in AWS
This page contains instructions to run K3s in AWS and deploy a sample application nginx. 

## Prep steps
- Make sure bastion host is configured properly https://github.com/praveensiddu/aws/blob/main/bastion/README.md#configure-bastion
  - for programmatic access
  - ssh key based login to other hosts.
  - security group to allow login to other hosts.
- You can also verify that your keypair is present here https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs:
## Either create using CLI or manually on the UI.
### Create Ubuntu instance using CLI
Create Ubuntu instance
- Login to bastion host
- Set environment varaible to the SSH key name used to SSH from bastion
  - export MYSSHKEYNAME=bastion-to-other-hosts
- rm -f create-instance.sh && wget https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/create-instance.sh
- bash create-instance.sh
### Create Ubuntu instance using GUI
- Create Ubuntu instance on UI with 
  - SSH key name used to SSH from bastion
  - with this link as userdata https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/cloud-init.sh
> If you forgot to create the instance with user-data you can wget this file and execute it
- if you are routing all traffic through a proxy(Bastion or load balancer) then you need only ssh from bastion in security group. Else open both http and https in security group.

## Install K3S
- Find the private IP of the newly created instance by visiting https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Instances:
- ssh from bastion to the new host. Example ssh ubuntu@<private ip address of the new instance>
- Install K3s by running "curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644"
## Deploy NGINX to test
- kubectl apply -f https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx_deployment.yaml
- kubectl apply -f https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx_service.yaml
- kubectl apply -f https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx_ingress.yaml
- Verify your deployment
  - kubectl get pods
  - curl localhost:80
  - kubectl delete deployment nginx
  - curl localhost:80
    - It should display "Service Unavailable"
  - kubectl apply -f https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx_deployment.yaml
  - curl localhost:80




