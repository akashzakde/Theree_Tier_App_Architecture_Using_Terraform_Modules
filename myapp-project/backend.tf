# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket  = "akashzterraform"
    key     = "myapp-project.tfstate"
    region  = "ap-south-1"
    profile = "default"
  }
}