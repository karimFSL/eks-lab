variable "AWS_ACCESS_KEY" {
    type        = string
    description = "AWS Access Key"
    sensitive   = true
}

variable "AWS_SECRET_KEY" {
    type        = string
    description = "AWS Secret Key"
    sensitive   = true
}

variable "AWS_REGION" {
    type        = string
    default     = "eu-west-3"
    description = "Région de notre instance ec2"
}