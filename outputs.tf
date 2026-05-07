output "lambda_arn" {
  description = "The ARN of the Lambda Function"
  value       = aws_lambda_function.this.arn
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = aws_lambda_function.this.function_name
}

output "lambda_invoke_arn" {
  description = "The ARN to be used for invoking Lambda Function from API Gateway"
  value       = aws_lambda_function.this.invoke_arn
}