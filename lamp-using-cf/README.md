# LAMP stack using cloud formation
This page contains instructions to create lamp stack using cloud formation template

###  Create AWS Linux2 Instance using cloud formation

- Login to Bastion host
- Set the following variables to approapriate values
  - export BASTION_SECURITY_GROUP=access-via-bastion-secgrp
  - export DBRootPassword=Abcd1234 
  - export MYSSHKEYNAME=bastion-to-other-hosts-key
  - export DBPassword=Abcd1234

- rm -f cloud-formation.yml && wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp-using-cf/cloud-formation.yml
- aws cloudformation validate-template --template-body file://cloud-formation.yml

###  Create instance 

- aws cloudformation create-stack   --stack-name stackfromcli --template-body  file://cloud-formation.yml --parameters  ParameterKey=DBPassword,ParameterValue=$DBPassword ParameterKey=DBRootPassword,ParameterValue=$DBRootPassword  ParameterKey=KeyName,ParameterValue=$MYSSHKEYNAME ParameterKey=SourceSSHSecurityGroupName,ParameterValue=$BASTION_SECURITY_GROUP




