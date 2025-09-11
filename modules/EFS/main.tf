terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

resource "aws_efs_file_system" "foo" {
    creation_token = "my-product"
    
    lifecycle_policy {
        transition_to_ia = "AFTER_30_DAYS"
    }
    
    tags = {
        Name = "MyProduct"
    }
}