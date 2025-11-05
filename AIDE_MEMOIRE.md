# 🚀 Aide-mémoire Kubernetes + AWS EKS + Helm

## 📦 Installation rapide (copier-coller)

### Installation complète en une ligne (Linux)
```bash
curl -o- https://raw.githubusercontent.com/votre-repo/install.sh | bash
```

### Ou téléchargez le script et exécutez:
```bash
chmod +x install-k8s-tools.sh
./install-k8s-tools.sh
```

---

## ⚙️ Configuration initiale

### 1. Configurer AWS
```bash
aws configure
# AWS Access Key ID: [votre clé]
# AWS Secret Access Key: [votre secret]
# Default region: eu-west-1
# Default output format: json
```

### 2. Se connecter au cluster EKS
```bash
# Template
aws eks update-kubeconfig --region <REGION> --name <CLUSTER_NAME>

# Exemple
aws eks update-kubeconfig --region eu-west-1 --name mon-cluster-prod
```

### 3. Vérifier la connexion
```bash
kubectl get nodes
kubectl cluster-info
```

---

## 🔍 Commandes kubectl essentielles

### Informations cluster
```bash
# Voir les nodes
kubectl get nodes
kubectl get nodes -o wide

# Info du cluster
kubectl cluster-info
kubectl cluster-info dump

# Contexte actuel
kubectl config current-context
kubectl config get-contexts
```

### Namespaces
```bash
# Lister les namespaces
kubectl get namespaces
kubectl get ns

# Créer un namespace
kubectl create namespace mon-app

# Utiliser un namespace par défaut
kubectl config set-context --current --namespace=mon-app
```

### Pods
```bash
# Lister les pods
kubectl get pods
kubectl get pods -A  # tous les namespaces
kubectl get pods -n kube-system
kubectl get pods -o wide

# Décrire un pod
kubectl describe pod <pod-name>

# Logs d'un pod
kubectl logs <pod-name>
kubectl logs <pod-name> -f  # follow (temps réel)
kubectl logs <pod-name> --previous  # logs du container précédent

# Se connecter à un pod
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec -it <pod-name> -- sh
```

### Deployments
```bash
# Lister les deployments
kubectl get deployments
kubectl get deploy

# Créer un deployment
kubectl create deployment nginx --image=nginx

# Scaler un deployment
kubectl scale deployment nginx --replicas=3

# Mettre à jour une image
kubectl set image deployment/nginx nginx=nginx:1.19

# Rollback
kubectl rollout undo deployment/nginx

# Historique
kubectl rollout history deployment/nginx

# Status
kubectl rollout status deployment/nginx
```

### Services
```bash
# Lister les services
kubectl get services
kubectl get svc

# Créer un service
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# Décrire un service
kubectl describe service nginx
```

### ConfigMaps et Secrets
```bash
# ConfigMaps
kubectl get configmaps
kubectl create configmap mon-config --from-literal=clé=valeur
kubectl describe configmap mon-config

# Secrets
kubectl get secrets
kubectl create secret generic mon-secret --from-literal=password=monsecret
kubectl describe secret mon-secret
```

### Debugging
```bash
# Événements
kubectl get events --sort-by=.metadata.creationTimestamp

# Tout voir dans un namespace
kubectl get all -n default

# Ressources consommées
kubectl top nodes
kubectl top pods
```

---

## 🎯 Commandes Helm essentielles

### Repositories
```bash
# Ajouter un repo
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add stable https://charts.helm.sh/stable

# Lister les repos
helm repo list

# Mettre à jour
helm repo update

# Rechercher un chart
helm search repo nginx
helm search hub wordpress
```

### Installation de charts
```bash
# Installer un chart
helm install mon-nginx bitnami/nginx

# Installer dans un namespace spécifique
helm install mon-nginx bitnami/nginx -n production

# Installer avec des valeurs personnalisées
helm install mon-nginx bitnami/nginx -f values.yaml

# Installer avec des valeurs en ligne
helm install mon-nginx bitnami/nginx --set service.type=LoadBalancer

# Dry-run (tester sans installer)
helm install mon-nginx bitnami/nginx --dry-run --debug
```

### Gestion des releases
```bash
# Lister les releases
helm list
helm list -A  # tous les namespaces

# Status d'une release
helm status mon-nginx

# Historique
helm history mon-nginx

# Mettre à jour une release
helm upgrade mon-nginx bitnami/nginx

# Mettre à jour avec de nouvelles valeurs
helm upgrade mon-nginx bitnami/nginx -f new-values.yaml

# Rollback
helm rollback mon-nginx 1  # revenir à la version 1

# Désinstaller
helm uninstall mon-nginx
```

### Chart development
```bash
# Créer un chart
helm create mon-chart

# Valider un chart
helm lint mon-chart

# Packager un chart
helm package mon-chart

# Voir les valeurs par défaut
helm show values bitnami/nginx

# Voir le README
helm show readme bitnami/nginx

# Voir tout
helm show all bitnami/nginx
```

### Templates
```bash
# Tester le rendu des templates
helm template mon-nginx bitnami/nginx

# Avec des valeurs
helm template mon-nginx bitnami/nginx -f values.yaml

# Installer depuis un chart local
helm install mon-nginx ./mon-chart
```

---

## 🔐 AWS EKS commandes

### Gestion des clusters
```bash
# Lister les clusters
aws eks list-clusters --region eu-west-1

# Décrire un cluster
aws eks describe-cluster --name mon-cluster --region eu-west-1

# Mettre à jour kubeconfig
aws eks update-kubeconfig --region eu-west-1 --name mon-cluster

# Avec un rôle IAM spécifique
aws eks update-kubeconfig --region eu-west-1 --name mon-cluster --role-arn arn:aws:iam::123456789:role/MonRole
```

### Node groups
```bash
# Lister les node groups
aws eks list-nodegroups --cluster-name mon-cluster --region eu-west-1

# Décrire un node group
aws eks describe-nodegroup --cluster-name mon-cluster --nodegroup-name mon-nodegroup --region eu-west-1
```

### Addons
```bash
# Lister les addons
aws eks list-addons --cluster-name mon-cluster --region eu-west-1

# Décrire un addon
aws eks describe-addon --cluster-name mon-cluster --addon-name vpc-cni --region eu-west-1
```

---

## 🛠️ Alias utiles

Ajoutez à votre `~/.bashrc` ou `~/.zshrc`:

```bash
# Kubectl
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'
alias kga='kubectl get all'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kl='kubectl logs'
alias kx='kubectl exec -it'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'

# Helm
alias h='helm'
alias hl='helm list'
alias hi='helm install'
alias hu='helm upgrade'
alias hd='helm uninstall'

# AWS
alias awsl='aws eks list-clusters'
alias awsk='aws eks update-kubeconfig'

# Contextes
alias kctx='kubectl config current-context'
alias kcx='kubectl config get-contexts'
alias kns='kubectl config set-context --current --namespace'
```

---

## 📋 Fichiers de configuration

### values.yaml exemple pour Helm
```yaml
replicaCount: 3

image:
  repository: nginx
  tag: "1.19"
  pullPolicy: IfNotPresent

service:
  type: LoadBalancer
  port: 80

resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 100m
    memory: 128Mi

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  targetCPUUtilizationPercentage: 80
```

### Manifest Kubernetes exemple
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: LoadBalancer
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```

---

## 🐛 Troubleshooting rapide

### Problème: "Unable to connect to the server"
```bash
# Vérifier AWS credentials
aws sts get-caller-identity

# Régénérer kubeconfig
aws eks update-kubeconfig --region <region> --name <cluster> --force
```

### Problème: "error: You must be logged in to the server (Unauthorized)"
```bash
# Vérifier les permissions IAM
# Vous devez avoir: eks:DescribeCluster sur le cluster
aws eks describe-cluster --name <cluster> --region <region>
```

### Problème: Pod en CrashLoopBackOff
```bash
kubectl logs <pod-name>
kubectl describe pod <pod-name>
kubectl get events --field-selector involvedObject.name=<pod-name>
```

### Problème: Service inaccessible
```bash
kubectl get endpoints <service-name>
kubectl describe service <service-name>
kubectl get pods -l app=<label>  # vérifier que les pods existent
```

---

## 📚 Ressources

- **kubectl cheat sheet**: https://kubernetes.io/docs/reference/kubectl/cheatsheet/
- **Helm docs**: https://helm.sh/docs/
- **AWS EKS workshop**: https://www.eksworkshop.com/
- **Kubernetes by example**: https://kubernetesbyexample.com/

---

## 💡 Tips

1. **Toujours** tester avec `--dry-run` avant d'appliquer
2. Utilisez des **namespaces** pour séparer vos environnements
3. **Versionnez** vos charts Helm et manifests dans Git
4. Configurez **RBAC** pour sécuriser l'accès
5. Utilisez **Helm values** plutôt que de modifier les charts
6. Activez les **logs** et le **monitoring** dès le début
7. Mettez en place des **resource limits** sur tous les pods
8. Utilisez **ConfigMaps** et **Secrets** pour la configuration
9. Testez vos déploiements en **staging** avant prod
10. Documentez votre infrastructure as code

---

**Version:** 1.0  
**Dernière mise à jour:** 2025
