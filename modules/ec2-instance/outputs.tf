# print the ec2's public ipv4 address
output "public_ipv4_address" {
  value = aws_instance.ec2.public_ip
}
