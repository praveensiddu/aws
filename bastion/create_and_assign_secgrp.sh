myinstanceid=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)
echo $myinstanceid
current_security_groups=$(aws ec2 describe-instances --instance-ids $myinstanceid --query Reservations[].Instances[].SecurityGroups[*].GroupId --output text)
echo $current_security_groups
aws ec2 create-security-group --description "Bastion security group to access to other hosts" --group-name access-via-bastion-secgrp --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=access-via-bastion}]" --query GroupId --output text
newsecuritygroup=$(aws ec2 describe-security-groups --group-names access-via-bastion-secgrp --query SecurityGroups[*].GroupId --output text)
echo $newsecuritygroup
aws ec2 modify-instance-attribute --instance-id $myinstanceid --groups $current_security_groups $newsecuritygroup
