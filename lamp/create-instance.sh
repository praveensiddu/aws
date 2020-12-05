if [[ $MYSSHKEYNAME == "" ]]
then
        echo "Set env MYSSHKEYNAME to the name of ssh key on bastion host used to access this instance. You can find your key name here"
        echo "https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs:"
        exit 1
fi
export AMZLINUZ2_AMI=$(aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --query 'Parameters[0].[Value]' --output text)
wget https://raw.githubusercontent.com/praveensiddu/aws/main/lamp/cloud-init.sh -O cloud-init.sh

aws ec2 run-instances --image-id $AMZLINUZ2_AMI --count 1 --instance-type t2.micro --key-name  $MYSSHKEYNAME 
