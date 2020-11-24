# Welcome to Tomcat on K3s in AWS


## Build HelloWorld python container image
wget https://raw.githubusercontent.com/praveensiddu/aws/main/tomcat-on-k3s/helloworld-python/sourcecode/app.py
wget https://raw.githubusercontent.com/praveensiddu/aws/main/tomcat-on-k3s/helloworld-python/sourcecode/Dockerfile
docker build . -t helloworld
sudo docker build . -t helloworld
docker save helloworld > helloworld.tar
sudo docker save helloworld > helloworld.tar
tar tvf helloworld.tar
Copy the helloworld.tar to K3s host
scp ./helloworld.tar ubuntu@172.31.18.237:.


On K3S host 
Run hte following command to find the current count of images 
sudo k3s ctr images list -q

sudo ls -l /var/lib/rancher/k3s/agent/containerd/io.containerd.content.v1.content/blobs/sha256 |wc -l

kubectl get pods | grep helloworld | cut -d ' ' -f 1


kubectl apply -f https://raw.githubusercontent.com/myannou/k3d-demo/master/nginx.yaml
  113  kubectl get pods
  114  sudo crictl image list
  115  curl http://localhost:8081
  116  kubectl get pods
  117  curl http://localhost:8082
  118  curl http://localhost:8099
  119  netstat -an |grep 8081
  120  curl http://localhost:8081
  121  curl http://localhost:80


 kubectl port-forward $(kubectl get pods | grep nginx | cut -d ' ' -f 1) 80 > log 2>&1 &
  133  kubectl get pods
  134  netstat -an |grep 80
  135  kubectl get pods
  136  kubectl exec
  137  kubectl exec  --help
  138  kubectl get pods
  139  kubectl exec nginx-7848d4b86f-w46ng -- /bin/bash
  140  kubectl exec nginx-7848d4b86f-w46ng -- date
  141  kubectl exec nginx-7848d4b86f-w46ng -- /bin/bash -il
  142  kubectl exec nginx-7848d4b86f-w46ng -i -t -- /bin/bash -il



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

