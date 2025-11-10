output "ec2_instance_id" {
  description = "ID de l'instance EC2"
  value       = aws_instance.my_ec2_instance.id
}

output "ec2_public_ip" {
  description = "Adresse IP publique de l'instance EC2"
  value       = aws_instance.my_ec2_instance.public_ip
}

output "ec2_public_dns" {
  description = "DNS public de l'instance EC2"
  value       = aws_instance.my_ec2_instance.public_dns
}

output "ec2_private_ip" {
  description = "Adresse IP privée de l'instance EC2"
  value       = aws_instance.my_ec2_instance.private_ip
}

output "web_server_url" {
  description = "URL du serveur web Apache"
  value       = "http://${aws_instance.my_ec2_instance.public_ip}"
}