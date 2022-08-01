terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Provider Block
provider "aws" {
# profile = "default"
# AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  access_key                  = var.access_key
  secret_key                  = var.secret_key
  region  = var.region
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-0533f2ba8a1995cf9" # Amazon Linux in us-east-1, update as per your region
  instance_type = var.instance_type
}
