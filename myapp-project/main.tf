# configure aws provider
provider "aws" {
  region  = var.region
  profile = "default"
}

# create vpc
module "vpc" {
  source                       = "../modules/vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

# create SG
module "sg" {
  source = "../modules/sg"
  app_port = var.app_port
  vpc_id = module.vpc.vpc_id
}
# create a ec2 instance
module "ec2-instance" {
  source                                          = "../modules/ec2-instance"
  instance_type                                   = var.instance_type
  vpc_security_group_ids                          = ["${module.sg.security_group_id}"]
  subnet_id                                       = "${module.vpc.public_subnet_az1_id}"
}