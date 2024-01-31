# create security group for the ec2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 80 and 22"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http access"
    from_port        = var.app_port[0]
    to_port          = var.app_port[0]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "ssh access"
    from_port        = var.app_port[1]
    to_port          = var.app_port[1]
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = "0"
    to_port          = "0"
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "EC2 SG"
  }
}
