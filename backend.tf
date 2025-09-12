#create s3 
resource "aws_s3_bucket" "mybucket" {
    bucket = "s3backendbucketdev124535"  
}
resource "aws_s3_bucket_acl" "backend_acl" {
  bucket = aws_s3_bucket.mybucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.mybucket.id
  versioning_configuration {
    status = "Enabled"
  }  
}

resource "aws_kms_key" "mys3key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mys3key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}


# create dynamodb table
resource "aws_dynamodb_table" "state_lock" {
  name ="state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name ="LockID"
    type = "S"
  }
}