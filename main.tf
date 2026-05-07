

resource "aws_lambda_function" "this" {
  function_name    = var.name
  description      = var.description
  handler          = var.handler
  runtime          = var.runtime
  role             = var.role  
  memory_size      = var.memory
  timeout          = var.timeout
  architectures    = var.architectures
  filename         = var.zip_file_path
  source_code_hash = filebase64sha256(var.zip_file_path)

  layers                         = var.layers
  reserved_concurrent_executions = var.concurrent_executions  
  kms_key_arn                    = coalesce(var.kms_key_arn, data.aws_kms_key.aws_managed.arn)
  
  publish = var.publish_function

  environment {
    variables = var.environment_variables
  }
  tags = var.tags  
}

resource "aws_lambda_alias" "this" {
  count = var.publish_function ? 1 : 0

  name             = var.alias
  function_name    = aws_lambda_function.this.function_name
  function_version = aws_lambda_function.this.version
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${aws_lambda_function.this.function_name}"
  retention_in_days = var.log_retention_days
}
