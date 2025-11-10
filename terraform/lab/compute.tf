resource "aws_instance" "my_ec2_instance" {
    ami = "ami-02cbf157cb22bb5b9"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance_sg.id]

    user_data = <<-EOF
		#!/bin/bash
        sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		sudo echo "<h1>Hello devopssec</h1>" > /var/www/html/index.html
	EOF
    
    tags = {
        Name = "terraform test"
        Environment = var.environment
        ManagedBy   = "Terraform"
    }

    # provisioner "local-exec" {
    #     when    = destroy
    #     command = "echo 'destruction de l'instance ${self.public_ip}' > ip_address.txt"
    # }
}