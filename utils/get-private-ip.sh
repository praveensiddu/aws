
aws ec2 describe-instances --filters "Name=tag:Name,Values=lamp" "Name=instance-state-name,Values=running" --query "Reservations[].Instances[].{Instance:PrivateIpAddress}" --output=text
