resource "aws_instance" "my_ec2_instance" {
  ami                    = "ami-02cbf157cb22bb5b9"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name               = var.key_name # Pour SSH


  user_data = file("${path.module}/scripts/install_artifactory.sh")
  # user_data_replace_on_change pour forcer le remplacement si le script change
  user_data_replace_on_change = true


  tags = {
    Name        = "terraform test"
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "Artifactory"
  }

  # Attendre que l'instance soit prête
  depends_on = [aws_security_group.instance_sg]

  # provisioner "local-exec" {
  #     when    = destroy
  #     command = "echo 'destruction de l'instance ${self.public_ip}' > ip_address.txt"
  # }
}