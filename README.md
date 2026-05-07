# Terraform AWS Lambda Module

This Terraform module creates an AWS Lambda Function with associated CloudWatch Log Group and optional alias configuration. The module automatically configures VPC settings and provides comprehensive Lambda function management capabilities.

## Features

- Create AWS Lambda Function with customizable runtime and configuration
- Create CloudWatch Log Group with configurable retention
- Support for Lambda aliases (optional)
- VPC configuration with default VPC and subnets
- Environment variables support
- KMS encryption support
- Lambda layers support
- Configurable memory, timeout, and concurrency settings
- Architecture support (x86_64 or arm64)
- Comprehensive tagging with validation

## Usage

### Basic Example

```hcl
module "lambda" {
  source = "path/to/terraform-aws-lambda"

  # Lambda configuration
  function_runtime     = "python3.12"
  function_code        = "path/to/your/lambda.zip"
  function_name        = "my-lambda-function"
  function_description = "My Lambda function description"
  function_handler     = "lambda_function.lambda_handler"
  function_role        = "arn:aws:iam::123456789012:role/lambda-execution-role"

  # CloudWatch configuration
  log_retention_days = 7

  # Required tags
  tags = {
    environment    = "development"
    Repository = "https://github.com/your-org/your-repo"
  }
}
```

### Advanced Example

```hcl
module "lambda" {
  source = "path/to/terraform-aws-lambda"

  # Lambda configuration
  function_runtime              = "python3.12"
  function_code                = "dist/app.zip"
  function_name                = "advanced-lambda-function"
  function_description         = "Advanced Lambda function with full configuration"
  function_handler             = "app.handler"
  function_role                = aws_iam_role.lambda_role.arn
  function_architectures       = ["arm64"]
  function_memory              = 512
  function_timeout             = 30
  function_concurrent_executions = 10
  function_layers              = ["arn:aws:lambda:us-east-1:123456789012:layer:my-layer:1"]

  # Publishing and aliasing
  publish_function = true
  function_alias   = "prod"

  # Environment variables
  environment_variables = {
    STAGE       = "production"
    LOG_LEVEL   = "INFO"
    API_ENDPOINT = "https://api.example.com"
  }

  # Security
  kms_key_arn = aws_kms_key.lambda_key.arn

  # CloudWatch configuration
  log_retention_days = 30

  # Tags
  tags = {
    environment    = "production"
    team          = "backend"
    cost_center   = "engineering"
    Repository = "https://github.com/your-org/your-repo"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| function_architectures | Supported architectures for the Lambda function | `list(string)` | `["x86_64"]` | no |
| function_runtime | The runtime environment for the Lambda function | `string` | n/a | yes |
| function_code | Path to the Lambda function code | `string` | n/a | yes |
| function_package_type | The package type for the Lambda function | `string` | `"Zip"` | no |
| function_name | Lambda function name | `string` | n/a | yes |
| function_description | Lambda function description | `string` | n/a | yes |
| function_handler | The entry point for the Lambda function | `string` | n/a | yes |
| function_layers | The list of Lambda Layer Version ARNs (maximum of 5) to attach to the Lambda function | `list(string)` | `[]` | no |
| function_memory | The amount of memory in MB allocated to the Lambda function | `number` | `128` | no |
| function_timeout | The amount of time in seconds that Lambda allows a function to run before stopping it | `number` | `10` | no |
| function_concurrent_executions | The amount of reserved concurrent executions for this Lambda function | `number` | `-1` | no |
| function_role | ARN of the IAM role associated with the Lambda function | `string` | n/a | yes |
| kms_key_arn | The ARN of the KMS key used to encrypt environment variables | `string` | `null` | no |
| publish_function | Whether to publish the Lambda function | `bool` | `false` | no |
| function_alias | The alias name for the function | `string` | `null` | no |
| environment_variables | Environment variables to set for the Lambda function | `map(string)` | `{}` | no |
| log_retention_days | The number of days to retain log events for the Lambda function | `number` | `1` | no |
| tags | Tags to apply to the resources (Repository tag is mandatory) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda | The ARN of the Lambda function |

## Examples

See the [examples](examples/) directory for complete usage examples:

- [Basic Python Lambda](examples/) - Simple Python Lambda function setup

## Notes

- The module automatically configures VPC settings using the default VPC and its associated subnets and security groups
- The `Repository` tag is mandatory and will cause validation errors if not provided
- Lambda aliases are only created when `publish_function` is set to `true`
- CloudWatch logs are automatically created with the naming convention `/aws/lambda/{function_name}`

## Contributing

When contributing to this module, please ensure:

1. All examples are tested and working
2. Documentation is updated for any new variables or outputs
3. Follow Terraform best practices and conventions

## License

This project is licensed under the MIT License - see the LICENSE file for details.
