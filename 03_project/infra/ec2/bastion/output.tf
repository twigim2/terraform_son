output "public-subnet-2a-id" {
    value = aws_instance.bastion.public_ip
}
