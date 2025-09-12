

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-22.04-amd64-server-*"]
  }

  owners = ["099720109477"]  
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

# variable "ami_id" {
#     description = "value of the AMI ID"
#     default = data.aws_ami.ubuntu.id
# }

variable "region" {
  default = "us-east-1"
}