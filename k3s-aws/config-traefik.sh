
#! /bin/bash
if [[ $MYDOMAIN == "" ]]
then
        echo "Set env MYDOMAIN to you kubernetes cluster domain"
        exit 1
fi
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./$MYDOMAIN.key -out ./$MYDOMAIN.cert -subj "/C=US/ST=New Sweden/L=Stockholm/O=none/OU=none/CN=$MYDOMAIN/emailAddress=test@$MYDOMAIN"


export MYDOMAIN_PUBLIC_CERT=$(base64 -w 0 base64 -w 0 ./$MYDOMAIN.cert)
export MYDOMAIN_PRIV_KEY=$(base64 -w 0 /etc/haproxy/certs/$MYDOMAIN.key)
wget https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/traefik_helm_values.yaml -O traefik_helm_values.yaml
sed -i "s/CHANGEME_MYDOMAIN_PRIV_KEY/$MYDOMAIN_PRIV_KEY/g" traefik_helm_values.yaml
sed -i "s/CHANGEME_MYDOMAIN_PUBLIC_CERT/$MYDOMAIN_PUBLIC_CERT/g" traefik_helm_values.yaml
sed -i "s/CHANGEME_MYDOMAIN/$MYDOMAIN/g" traefik_helm_values.yaml
