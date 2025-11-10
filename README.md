# EKS Lab

Ce repository contient des commandes et procédures pour gérer des clusters Amazon EKS.

## Table des matières
- [Prérequis](#prérequis)
- [Installation des outils](#installation-des-outils)
- [Gestion des clusters EKS](#gestion-des-clusters-eks)
- [Configuration kubectl](#configuration-kubectl)
- [Commandes utiles](#commandes-utiles)

## Prérequis

- Un compte AWS configuré
- Accès à un terminal Linux/Unix

## Installation des outils

### AWS CLI
```bash
# Vérifier si AWS CLI est installé
aws --version

# Si pas installé :
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

# Configurer AWS CLI
aws configure

# Tester la connexion
aws sts get-caller-identity
```

### kubectl
```bash
# Télécharger kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Rendre le binaire exécutable
chmod +x kubectl

# Déplacer vers /usr/local/bin
sudo mv kubectl /usr/local/bin/

# Vérifier l'installation
kubectl version --client
```

## Gestion des clusters EKS

### Créer un cluster
```bash
eksctl create cluster \
  --name test-cluster \
  --version 1.17 \
  --region eu-west-3 \
  --nodegroup-name linux-nodes \
  --node-type t2.micro \
  --nodes 2
```

### Supprimer un cluster
```bash
eksctl delete cluster --name demo-cluster
```

### Lister les clusters
```bash
eksctl get cluster --region us-east-1
```

### Décrire un cluster
```bash
aws eks describe-cluster --name eks-from-eksctl --region us-east-1
```

## Configuration kubectl

### Configurer l'accès au cluster
```bash
# Template
aws eks update-kubeconfig --region <votre-region> --name <nom-de-votre-cluster>

# Exemple
aws eks update-kubeconfig --region eu-west-3 --name demo-cluster
```

### Changer de contexte
```bash
kubectl config use-context <nom-contexte>
```

### Associer un fournisseur OIDC IAM
```bash
# Template
eksctl utils associate-iam-oidc-provider \
    --region region-code \
    --cluster <cluster-name> \
    --approve

# Exemple
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster eksdemo1 \
    --approve
```

## Commandes utiles

### Vérifier les nœuds
```bash
kubectl get nodes
kubectl get nodes -o wide
```

### Vérifier les ressources du cluster
```bash
# Voir tous les pods système
kubectl get pods -A

# Voir les services
kubectl get svc -A

# Informations sur le cluster
kubectl cluster-info
```

### Éditer des ressources
```bash
kubectl -n argocd edit <ressource>
```