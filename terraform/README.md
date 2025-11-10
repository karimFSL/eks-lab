# Terraform - Guide d'utilisation

Guide complet pour l'utilisation de Terraform avec AWS.

## Table des matières
- [Configuration initiale](#configuration-initiale)
- [Workflow de base](#workflow-de-base)
- [Gestion des variables](#gestion-des-variables)
- [Structure de projet](#structure-de-projet)
- [Backend et State](#backend-et-state)
- [Workspaces](#workspaces)
- [Commandes avancées](#commandes-avancées)
- [Bonnes pratiques](#bonnes-pratiques)

## Configuration initiale

Configuration pour Terraform


### Configurer AWS CLI

Terraform utilise les mêmes credentials AWS. Il peut les récupérer de plusieurs façons (par ordre de priorité) :
- Variables d'environnement : AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
- Fichier de credentials : ~/.aws/credentials
- Fichier de config : ~/.aws/config
- Profils IAM (si vous êtes sur une instance EC2)

```bash
# Cette commande affiche votre configuration actuelle ( région, format de sortie, etc..)
aws configure list
# Cette commande permet de connecter un utilisateur 
aws configure --profile my-user
# Cette commande permet de tester la connexion avec votre vompte aws
aws sts get-caller-identity

```

### Initialiser Terraform
```bash
# À exécuter à chaque fois que vous démarrez un nouveau projet Terraform
terraform init
```

## Workflow de base

### 1. Planifier les changements
```bash
# Créer un plan d'exécution pour prévisualiser les changements
terraform plan
```

### 2. Appliquer les changements
```bash
# Créer les ressources
terraform apply

# Avec auto-approbation (attention en production !)
terraform apply --auto-approve
```

### 3. Mettre à jour l'infrastructure
```bash
# Réinitialiser et appliquer les changements
terraform init && terraform apply
```

### 4. Détruire les ressources
```bash
terraform destroy
```

## Gestion des variables

### Passer des variables en ligne de commande
```bash
terraform apply -var 'AWS_REGION=us-east-2' -var 'AWS_AMI=ami-07c1207a9d40bc3bd'
```

### Utiliser des fichiers de variables
```bash
terraform apply -var-file="aws-access.tfvars" -var-file="aws-config.tfvars"
```

### Fichiers de variables auto-chargés

Terraform charge automatiquement les fichiers suivants :
- `terraform.tfvars`
- `*.auto.tfvars`

Pour d'autres noms de fichiers, utilisez l'option `-var-file`.

## Structure de projet

### Arborescence recommandée
```
projet/
├── main.tf                 # Ressources principales
├── providers.tf            # Configuration des providers
├── variables.tf            # Déclaration des variables
├── outputs.tf              # Outputs du projet
├── terraform.tfvars        # Variables secrètes (ne pas commiter !)
└── modules/
    └── mon-module/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### Organisation des fichiers

- **main.tf** : Ressources principales
- **providers.tf** : Configuration des providers (AWS, Azure, etc.)
- **variables.tf** : Déclaration des variables principales
- **outputs.tf** : Valeurs de sortie
- **terraform.tfvars** : Valorisation des variables (⚠️ à exclure de Git pour les secrets)

## Gestion des variables

### Passer des variables en ligne de commande
```bash
terraform apply -var 'AWS_REGION=us-east-2' -var 'AWS_AMI=ami-07c1207a9d40bc3bd'
```

### Utiliser des fichiers de variables
```bash
terraform apply -var-file="aws-access.tfvars" -var-file="aws-config.tfvars"
```

### Fichiers de variables auto-chargés

Terraform charge automatiquement les fichiers suivants :
- `terraform.tfvars`
- `*.auto.tfvars`

Pour d'autres noms de fichiers, utilisez l'option `-var-file`.

### Ordre de priorité des variables

Terraform charge les variables selon un ordre de priorité précis. **La dernière valeur chargée écrase les précédentes** :
```
Priorité croissante (du moins au plus prioritaire) :

⑥ Valeurs par défaut (default dans variables.tf)
   ↓ écrasé par
⑤ Fichier terraform.tfvars
   ↓ écrasé par
④ Fichier terraform.tfvars.json
   ↓ écrasé par
③ Fichiers *.auto.tfvars (ordre alphabétique)
   ↓ écrasé par
② Variables d'environnement (TF_VAR_nom_variable)
   ↓ écrasé par
① Options -var ou -var-file en ligne de commande
```

**Exemple concret :**
```bash
# 1. Dans variables.tf (Priorité la plus basse)
variable "environment" {
  default = "dev"  # Valeur par défaut
}

# 2. Dans terraform.tfvars (Écrase la valeur par défaut)
environment = "staging"

# 3. Variable d'environnement (Écrase terraform.tfvars)
export TF_VAR_environment="preprod"

# 4. En ligne de commande (Écrase tout le reste - Priorité maximale)
terraform apply -var="environment=prod"

# Résultat final : environment = "prod"
```

**Cas d'usage pratiques :**
```bash
# Utiliser une variable d'environnement
export TF_VAR_AWS_REGION="eu-west-3"
export TF_VAR_environment="prod"
terraform apply  # Les variables sont automatiquement chargées

# Forcer une valeur en ligne de commande (override tout)
terraform apply -var="environment=prod" -var="AWS_REGION=us-east-1"

# Utiliser un fichier de variables spécifique pour un environnement
terraform apply -var-file="environments/prod.tfvars"
```

**Astuce :** Pour les secrets (mots de passe, clés API), utilisez plutôt les variables d'environnement ou un gestionnaire de secrets, jamais dans les fichiers `.tfvars` commitées dans Git.


## Backend et State

### Configuration du backend S3
```hcl
terraform {
  backend "s3" {
    bucket         = "mybucket"
    key            = "path/to/my/key"
    region         = "eu-west-1"
    dynamodb_table = "terraform_state"
  }
}
```

### Permissions IAM requises

Le rôle/utilisateur Terraform doit avoir les permissions suivantes :

- `s3:ListBucket` sur `arn:aws:s3:::mybucket`
- `s3:GetObject` sur `arn:aws:s3:::mybucket/path/to/my/key`
- `s3:PutObject` sur `arn:aws:s3:::mybucket/path/to/my/key`

### Inspecter le state
```bash
# Lister toutes les ressources
terraform state list

# Afficher les détails d'une ressource
terraform state show <resource-name>
```

## Workspaces

### Gérer les environnements
```bash
# Créer un nouveau workspace
terraform workspace new prod

# Lister les workspaces
terraform workspace list
  default
* prod

# Changer de workspace
terraform workspace select default
```

### Utiliser les workspaces dans le code
```hcl
resource "aws_instance" "example" {
  # Nom dynamique selon l'environnement
  tags = {
    Name = "Serveur-${terraform.workspace}"
  }
}

# Conditionnalité basée sur le workspace
locals {
  high_availability = terraform.workspace == "prod" ? true : false
}
```

**Note :** Les states sont séparés par workspace (ex: `dev.tfstate`, `prod.tfstate`)

## Commandes avancées

### Importer des ressources existantes
```bash
# Importer une ressource existante dans Terraform
# Utile pour modifier des instances en cours plutôt que de les recréer
terraform import <resource-type>.<resource-name> <resource-id>
```

### Autres commandes utiles
```bash
# Formater automatiquement les fichiers .tf
# This command will fix any formatting errors you have in your configuration files and make them look nicer and easier to read.
terraform fmt

# Vérifier la syntaxe
terraform validate

# Afficher les valeurs de sortie
terraform output

# Afficher le graphe des dépendances
terraform graph
```

## Bonnes pratiques

### Recommandations générales

1. **Utiliser un backend distant** (S3 + DynamoDB) pour le state
2. **Ne jamais commiter** les fichiers `.tfvars` cont
3. **Test** Implement automated testing for your Terraform code using tools like Terratest to catch issues early in the development process.
4. **tagging** Apply consistent tagging to your resources for better organization, cost tracking, and management.
5. **secret management** handle secret
6. **review and approval process** Set up a process for reviewing and approving Terraform changes before applying them to production environments.
7. **plan and apply in separate steps** terraform plan -out=tfplan then terraform apply tfplan : to avoid accidental changes.
8. **Handle Terraform State Locks Effectively**  Ensure effective handling of state locks, especially in scenarios where multiple team members or automation scripts might be interacting with the same state.
