
module "events_table" {
  source       = "../modules/dynamodb"
  table_name   = "${var.project_name}-${var.environment}-events"
  hash_key     = "event_id"   # ← THIS is the value
  project_name = var.project_name
  environment  = var.environment
}
