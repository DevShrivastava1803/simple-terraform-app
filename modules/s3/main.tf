terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "S3bucket" {
    bucket = "simple-terraform-s3-bucket"

    tags = {
        Name ="Simple bucket"
    } 
}