resource "aws_s3_bucket" "S3bucket" {
    bucket = "simple-terraform-s3-bucket"

    tags = {
        Name ="Simple bucket"
    } 
}