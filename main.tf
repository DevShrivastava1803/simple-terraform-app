terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 3.74.2"
        }
    }
    required_version = ">= 1.3.0"
}

module "ec2" {
  source = "./modules/ec2"
} 
 
module "s3" {
  source = "./modules/s3"
}


# module "subnet" {
#   source = "./modules/subnet"
# }

/*
module "EFS" {
  source = "./modules/EFS"
}

module "iam" {
  source = "./modules/Iam"
}

module "Rds" {
  source = "./modules/Rds"
}
 */