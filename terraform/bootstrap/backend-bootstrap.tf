# Create S3 bucket for Terraform state
resource "aws_s3_bucket" "tf_state" {
  bucket = "dn-cvs-challenge-tf-state-bucket"  # MUST be globally unique

  force_destroy = true  # allows bucket deletion even if it has files (good for testing)
}

# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id  # reference to the bucket above

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # encrypts all objects automatically
    }
  }
}

# Create DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks"  # name of the locking table
  billing_mode = "PAY_PER_REQUEST" # no need to manage capacity
  hash_key     = "LockID"          # required for Terraform locking

  attribute {
    name = "LockID"  # primary key name
    type = "S"       # string type
  }
}
