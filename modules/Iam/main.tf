terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

resource "aws_iam_role" "role_terraform" {
  name = "new-user-dev"


  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

}
