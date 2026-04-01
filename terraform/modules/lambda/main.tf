
resource "aws_lambda_function" "this" {
  function_name = "${var.project_name}-${var.environment}-event-logger"
  role          = var.lambda_role_arn
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"

  filename         = var.filename
  source_code_hash = filebase64sha256(var.filename)

  timeout = 10

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }
}
