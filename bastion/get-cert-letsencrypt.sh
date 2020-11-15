if [[ $1 == "" ]]
then
        echo "Usage $0 <example.com>"
        exit 1
fi


sudo amazon-linux-extras install epel
sudo yum install certbot -y

# Temporariry stop haproxy
sudo systemctl stop haproxy

sudo certbot certonly --standalone --preferred-challenges http --http-01-port 80 -d $1 -d www.$1

