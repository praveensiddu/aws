# Welcome to build environment in AWS
This page contains instructions to create a build host to build web applications using maven and containerize it.

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
  - export INSTNAME=build-host
- wget https://raw.githubusercontent.com/praveensiddu/aws/main/build-host/ansible-setup.yml -O ansible-setup.yml
- ansible-playbook  -u ubuntu  -e  "INSTNAME=$INSTNAME"  ansible-setup.yml
- export INST_IP=$(bash get-private-ip.sh $INSTNAME)
- curl http://$INST_IP:80


# Install & configure

- git clone https://github.com/JavaTutorialNetwork/Tutorials.git
- cd Tutorials/SimpleServlet
- mvn clean
- mvn package
   and the war file will be built in target/SimpleServlet-1.war
- 