terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    required_version = ">= 1.3.0"
}

provider "aws" {
    region = "us-east-1"
}

module "ec2" {
  source = "modules/ec2"
} 

module "s3" {
  source = "modules/s3"
}

module "EFS" {
  source = "modules/EFS"
}

module "iam" {
  source = "modules/Iam"
}

module "Rds" {
  source = "modules/Rds"
}
module "subnet" {
  source = "modules/subnet"
}