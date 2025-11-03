provider "aws" {
    profile = "my-user"
    region = var.AWS_REGION
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
    
      # Les credentials viennent automatiquement de ~/.aws/credentials
      // autre solution
}


terraform {
  required_version = ">= 1.0"

  required_providers {
    
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.94"
    }
  }
}