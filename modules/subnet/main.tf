terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.6.0/28"

  tags = {
    Name = "Main"
  }
}

resource "aws_vpc" "mainvpc" {
  
}