/*# configured aws provider with proper credentials
provider "aws" {
  region    = 
  profile   = 
}


# create default vpc if one does not exit
resource "aws_default_vpc" "default_vpc" {

  tags    = {
    Name  = 
  }
}


# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


# create default subnet if one does not exit
resource "aws_default_subnet" "default_az1" {
  availability_zone = 

  tags   = {
    Name = 
  }
}*/

# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon-linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

# launch the ec2 instance and install website
resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon-linux.id
  instance_type          = var.instance_type
  associate_public_ip_address = true
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = "gitops-key"
  user_data              = file("${path.module}/user-data-apache.sh")

  tags = {
    Name = "Myapp Server"
  }
}