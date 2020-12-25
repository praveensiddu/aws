# Welcome to K3s in AWS
This page contains instructions to run K3s in AWS and deploy a sample application nginx. 

## Prep steps
- Make sure bastion host is configured properly https://github.com/praveensiddu/aws/blob/main/bastion/README.md#configure-bastion
  - for programmatic access
  - ssh key based login to other hosts.
  - security group to allow login to other hosts.
- You can also verify that your keypair is present here https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs:

# Install & configure
Either use the fully automated approach or manually execute the commands
## Automated Approach
- Login to bastion host and set the following env variables.
  - export ANSIBLE_HOST_KEY_CHECKING=false
  - export INSTNAME=k3s-nginx
  - export MYDOMAIN=k3s.praveentest.com
  - sudo sed '/BEGIN PRIVATE KEY/Q' /etc/haproxy/certs/$MYDOMAIN.pem > /etc/haproxy/certs/$MYDOMAIN.pub
  - sudo grep "BEGIN PRIVATE KEY" /etc/haproxy/certs/$MYDOMAIN.pem > /etc/haproxy/certs/$MYDOMAIN.key
  - sudo sed '0,/BEGIN PRIVATE KEY/D' /etc/haproxy/certs/$MYDOMAIN.pem >> /etc/haproxy/certs/$MYDOMAIN.key
  - export MYDOMAIN_PUBLIC_CERT=$(base64 -w 0 /etc/haproxy/certs/$MYDOMAIN.pub)
  - export MYDOMAIN_PRIV_KEY=$(base64 -w 0 /etc/haproxy/certs/$MYDOMAIN.key)
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/ansible-setup.yml -O ansible-setup.yml
- ansible-playbook  -u ubuntu  -e  "INSTNAME=$INSTNAME"  ansible-setup.yml
- export INST_IP=$(bash get-private-ip.sh $INSTNAME)
- curl http://$INST_IP:80
- update the /etc/haproxy/haproxy.cfg on load balancer host to point to this IP "echo $INST_IP"
- sudo systemctl restart haproxy
- access nginx page http://yourdomain/

## Manual Approach
Use these steps if you prefer not to use the fully automated approach.

## Either create using CLI or UI.
### Create AWS Linux2 Instance using CLI

## Either create using CLI or manually on the UI.
### Create Ubuntu instance using CLI
Create Ubuntu instance
- Login to bastion host
- Set environment varaible to the SSH key name used to SSH from bastion
  - export MYSSHKEYNAME=bastion-to-other-hosts-key
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
- ssh from bastion to the new host. Example ssh ubuntu@"private ip address of the new instance"
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




