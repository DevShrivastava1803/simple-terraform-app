terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3a.large"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  port     = 3306

  vpc_security_group_ids = ["sg-12345678"]

  subnet_ids = ["subnet-12345678", "subnet-87654321"]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  deletion_protection = true
}
