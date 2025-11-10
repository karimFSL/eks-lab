# ArgoCD - Guide d'installation et d'utilisation

Ce guide couvre l'installation et la gestion d'ArgoCD sur Kubernetes.

## Table des matières
- [Installation](#installation)
- [Configuration](#configuration)
- [ArgoCD CLI](#argocd-cli)
- [Gestion des applications](#gestion-des-applications)
- [Accès et exposition](#accès-et-exposition)
- [Dépannage](#dépannage)

## Installation

### Prérequis
```bash
# Créer le namespace
kubectl create namespace argocd
```

### Méthodes d'installation

#### Option 1 : Via Helm (recommandé)
```bash
# Ajouter le repository Helm
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Installer ArgoCD
helm install argocd argo/argo-cd --namespace argocd

# Vérifier l'installation
helm list -n argocd
```

#### Option 2 : Via kubectl (manifest)
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

#### Option 3 : Via Terraform
```bash
# Définir l'état désiré dans Terraform, puis :
terraform apply
```

### Surveiller le déploiement
```bash
# Surveiller les pods pendant l'installation
kubectl get pods -n argocd -w
```

## Configuration

### Changer le namespace par défaut
```bash
kubectl config set-context --current --namespace=argocd
```

### Récupérer le mot de passe admin
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

### Récupérer l'URL du serveur
```bash
export ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname')
```

## Accès et exposition

### Exposer via LoadBalancer
```bash
# Patcher le service (ClusterIP par défaut -> LoadBalancer)
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

### Exposer via Ingress (recommandé pour production)

**Avantages :**
- 1 seul LoadBalancer pour tous vos services
- Certificat SSL gratuit
- Nom de domaine personnalisé (ex: argocd.votre-entreprise.com)
```bash
# Configurer un Ingress avec nom de domaine + SSL
# (Voir documentation Ingress Controller)
```

## ArgoCD CLI

### Installation
```bash
# Télécharger ArgoCD CLI
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64

# Installer
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

# Nettoyer
rm argocd-linux-amd64
```

### Connexion
```bash
argocd login <ArgoCD-URL>
```

## Gestion des applications

### Créer une application

Trois méthodes disponibles :
1. Via l'interface web ArgoCD
2. Via ArgoCD CLI
3. Via fichier YAML déclaratif

### Lister les applications
```bash
argocd app list
```

### Obtenir les détails d'une application
```bash
argocd app get <app-name>
```

### Synchroniser une application
```bash
# Lancer la synchronisation
argocd app sync my-app

# Surveiller le statut de synchronisation
argocd app get my-app
```

## Dépannage

### Redémarrer le serveur ArgoCD
```bash
kubectl rollout restart deployment argocd-server -n argocd
```

### Nettoyer le namespace
```bash
# Supprimer toutes les ressources
kubectl delete all --all -n argocd

# Ou supprimer et recréer le namespace
kubectl delete namespace argocd
kubectl create namespace argocd
```

### Désinstaller ArgoCD (Helm)
```bash
helm uninstall argocd -n argocd
```