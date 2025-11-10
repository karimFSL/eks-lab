variable "AWS_REGION" {
  description = "Région AWS où les ressources seront créées"
  type        = string
  default     = "eu-west-3"
  
  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.AWS_REGION))
    error_message = "La région doit être au format valide (ex: eu-west-1, us-east-1)."
  }
}

variable "environment" {
  description = "Environnement de déploiement"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "L'environnement doit être : dev, staging ou prod."
  }
}

variable "project_name" {
  description = "Nom du projet (utilisé pour le tagging des ressources)"
  type        = string
  default     = "example-project"
  
  validation {
    condition     = length(var.project_name) > 0 && length(var.project_name) <= 50
    error_message = "Le nom du projet doit contenir entre 1 et 50 caractères."
  }
}