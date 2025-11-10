# équivalent à aws ec2 describe-images --owners 099720109477 --filters 'Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20200408'
# data "aws_ami" "ubuntu-ami" {
#     most_recent = true

#     filter {
#         name   = "name"
#         values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20200408"]
#     }

#     owners = ["099720109477"] # Canonical
# }