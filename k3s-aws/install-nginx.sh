wget https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx/nginx_deployment.yaml -O nginx_deployment.yaml
wget https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx/nginx_service.yaml -O nginx_service.yaml
wget https://raw.githubusercontent.com/praveensiddu/aws/main/k3s-aws/manifests/nginx/nginx_ingress.yaml -O nginx_ingress.yaml
kubectl apply -f nginx_deployment.yaml
kubectl apply -f nginx_service.yaml
sed -i "s/CHANGEME_MYDOMAIN/$MYDOMAIN/g" nginx_ingress.yaml
kubectl apply -f nginx_ingress.yaml

