# eks-lab
eks lab

eksctl command
 eksctl create cluster \
> --name test-cluster \
> --version 1.17 \
> --region eu-west-3 \
> --nodegroup-name linux-nodes \
> --node-type t2.micro \
> --nodes 2

#delete cluster
eksctl deleter cluster --name demo-cluster

install aws cli
# Vérifier si AWS CLI est installé
aws --version

# Si pas installé :
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# commandes utiles
aws configure
# Tester la connexion
aws sts get-caller-identity

eksctl get cluster --region us-east-1
% aws eks describe-cluster --name eks-from-eksctl --region us-east-1
% kubectl get nodes -o wide

# installer kubectl
# Télécharger kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Rendre le binaire exécutable
chmod +x kubectl
# Déplacer vers /usr/local/bin
sudo mv kubectl /usr/local/bin/
# Vérifier l'installation
kubectl version --client


# Configurer kubectl pour accéder à votre cluster EKS
aws eks update-kubeconfig --region eu-west-3 --name demo-cluster
# Vérifier la connexion
kubectl get nodes


# Voir tous les pods système
kubectl get pods -A
# Voir les services
kubectl get svc -A
# Informations sur le cluster
kubectl cluster-info

# Template
eksctl utils associate-iam-oidc-provider \
    --region region-code \
    --cluster <cluter-name> \
    --approve

# Replace with region & cluster name
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster eksdemo1 \
    --approve
