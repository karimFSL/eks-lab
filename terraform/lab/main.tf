#versioning your module
# module "web_server" {
#   source = "git::https://github.com/example/web_server.git?ref=v1.0.0"

#   // Module-specific variables
# }


# leverage module registry

# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "2.81.0"

#   // Module-specific variables
# }


# excute script 
# provisioner "local-exec" {
#   command = "./setup_script.sh"
# }




# Clearly define dependencies between resources using the depends_on attribute to ensure proper resource creation order.
# resource "aws_security_group" "example" {
#   // ...

#   depends_on = [
#     aws_vpc.example,
#     aws_subnet.example,
#   ]
# }