terraform {
  required_version = ">= 1.0"
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.AWS_REGION
  default_tags {
    tags = {
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }

  #Follow the principle of least privilege when configuring provider credentials
  # assume_role {
  #   role_arn = "arn:aws:iam::ACCOUNT_ID:role/terraform"
  # }
}


