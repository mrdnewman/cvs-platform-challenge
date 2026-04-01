
module "events_table" {
  source       = "../modules/dynamodb"
  table_name   = "${var.project_name}-${var.environment}-events"
  hash_key     = "event_id"   # ← THIS is the value
  project_name = var.project_name
  environment  = var.environment
}

module "lambda_iam" {
  source       = "../modules/iam"
  project_name = var.project_name
  environment  = var.environment
}

module "lambda_function" {
  source = "../modules/lambda"

  project_name    = var.project_name
  environment     = var.environment
  lambda_role_arn = module.lambda_iam.lambda_role_arn
  filename        = "${path.module}/../../app/function.zip"
  table_name      = module.events_table.table_name
}
