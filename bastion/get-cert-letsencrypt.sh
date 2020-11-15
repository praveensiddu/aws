
sudo amazon-linux-extras install epel
sudo yum install certbot -y

# Temporariry stop haproxy
sudo systemctl stop haproxy

sudo certbot certonly --standalone --preferred-challenges http --http-01-port 80 -d example.com -d www.example.com
