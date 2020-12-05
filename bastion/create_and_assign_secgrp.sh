if [[ $1 == "" ]]
then
        echo "Usage $0 access-via-bastion-secgrp"
        exit 1
fi
myinstanceid=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)
echo $myinstanceid
current_security_groups=$(aws ec2 describe-instances --instance-ids $myinstanceid --query Reservations[].Instances[].SecurityGroups[*].GroupId --output text)
echo $current_security_groups
aws ec2 create-security-group --description "Bastion security group to access to other hosts" --group-name $1 --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=access-via-bastion}]" --query GroupId --output text
newsecuritygroupId=$(aws ec2 describe-security-groups --group-names $1 --query SecurityGroups[*].GroupId --output text)
echo $newsecuritygroupId
aws ec2 modify-instance-attribute --instance-id $myinstanceid --groups $current_security_groups $newsecuritygroupId
