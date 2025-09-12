

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