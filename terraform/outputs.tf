output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the provisioned VPC"
}

output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "The ID of the Public Subnet"
}

output "private_subnet_id" {
  value       = aws_subnet.private.id
  description = "The ID of the Private Subnet"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "The ID of the Internet Gateway"
}
output "web_server_public_ip" {
  value       = aws_instance.web.public_ip
  description = "The public IP address of the deployed web server"
}