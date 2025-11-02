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
