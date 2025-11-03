data "aws_vpc" "main" {
    id = ""
}

output "vpc_cidr" {
  value = data.aws_vpc.main.cidr_block
}