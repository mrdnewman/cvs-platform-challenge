resource "aws_dynamodb_table" "this" {
  name         = var.table_name          # DynamoDB table name
  billing_mode = "PAY_PER_REQUEST"       # on-demand billing
  hash_key     = var.hash_key            # partition key

  attribute {
    name = var.hash_key                  # key name
    type = "S"                           # string type
  }

  point_in_time_recovery {
    enabled = true                       # enables PITR
  }

  server_side_encryption {
    enabled = true                       # encrypt table at rest
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
