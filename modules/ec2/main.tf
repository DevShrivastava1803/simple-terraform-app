terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "simpleinstance" {
    ami = var.ami_id

    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.main.id]
    tags = {
      Name = "EC2 Instance"
    }
}


resource "aws_security_group" "main" {
    name        = "EC2-webserver-SG-1"
  description = "Webserver for EC2 Instances"

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

