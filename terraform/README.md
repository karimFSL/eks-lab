# configure user
aws configure --profiler my-user

lancer terraform init à chaque fois que vous démarrez un nouveau code de terraform

La commande terraform plan est utilisée pour créer un plan d'exécution

créer notre ressource Terraform avec terraform apply

update avec terraform init && terraform apply
destroy avec terrafom destroy


# variables 
terraform apply -var 'AWS_REGION=us-east-2' -var 'AWS_AMI=ami-07c1207a9d40bc3bd'
# fichier de variables
terraform apply -var-file="aws-access.tfvars" -var-file="aws-config.tfvars"


//vars tfvars
Pour information, si vous nommez votre fichier à la lettre près terraform.tfvars ou toute variation de *.auto.tfvars, alors Terraform le chargera automatiquement, sinon si vous décidez de nommer votre fichier autrement, vous pouvez utiliser l'option -var-file pour spécifier votre fichier de valorisation, comme par exemple :

# arborescence example
main.tf
providers.tf
variables.tf
output.tf
modules
    variables.tf pour les variables principales
    main.tf
    outputs.tf
    Le fichier terraform.tfvars pour les variables secrètes qui ne sera pas stocké dans votre repository git


bonnes pratiques 
voir https://blog.stephane-robert.info/docs/infra-as-code/provisionnement/terraform/


terraform {
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "eu-west-1"
    dynamodb_table = "terraform_state"
  }
}

Terraform doit posséder les permissions IAM suivantes pour stocker et lire les données du state:

s3:ListBucket on arn:aws:s3:::mybucket s3:GetObject on arn:aws:s3:::mybucket/path/to/my/key s3:PutObject on arn:aws:s3:::mybucket/path/to/my/key


terraform state list
terraform state show

# workspace
dev.tfstate

terraform workspace new prod
terraform workspace list
  default
* prod

terraform workspace select default

    Name = "Serveur-${terraform.workspace}"
    high_availability = (terraform.workspace == "prod") ? true : false



terraform import pour modifier instance en cours plutôt que de créer