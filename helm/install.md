# Add the Argo CD Helm Repository
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update


# Install Argo CD in the argocd Namespace
kubectl create namespace argocd
helm install argocd argo/argo-cd --namespace argocd
## ou en passant par kubectl avec le manifest
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
## ou bien en passant par terraform 
desired state then terraform apply command 



# helm list 
helm list -n argocd

# list tous les helm chart installé
 helm list -n argocd

 # Supprimer tout ce qui reste dans le namespace
kubectl delete all --all -n argocd

# Ou supprimer et recréer le namespace
kubectl delete namespace argocd
kubectl create namespace argocd

# Surveiller les pods pendant l'installation
kubectl get pods -n argocd -w

# récupérer password argocd
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# Changer en LoadBalancer car argocd en clusterIP par défaut
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'


## argocd cli isntall
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# login to argocd
argocd login <Argocd URL>

# get apps
argocd app list
argocd app get <app name>

# sync app 
argocd app sync my-app

# monitor the sync status
argocd app get my-app

# Restart the argocd-server
kubectl rollout restart deployment argocd-server -n argocd

# créer appli avec argocd ui ou bien argocd cli ou encore fichier yaml 

# switch current namespace 
kubectl config set-context --current --namespace=argocd


# ingress
# Encore mieux : Ingress avec nom de domaine + SSL
# 1 seul LoadBalancer pour tous vos services
# + certificat SSL gratuit
# + nom de domaine personnalisé (argocd.votre-entreprise.com)


export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`
