# mandatory variables

variable "name" {
  description = "The name of the lambda function"
  type        = string
}

variable "description" {
  description = "Description of what the function does"
  type        = string
}

variable "handler" {
  description = "The function entrypoint in your code"
  type        = string
}

variable "runtime" {
  description = "The runtime environment for the Lambda function"
  type        = string
}

variable "architectures" {
  description = "The architectures for the Lambda function"
  type        = list(string)
  default = ["arm64"]  
}

variable "role" {
  description = "ARN da função IAM associada à função Lambda"
  type        = string
}

variable "zip_file_path" {
  description = "The absolute path to the ZIP file containing the Lambda source code"
  type        = string
}

# CloudWatch configuration

variable "log_retention_days" {
  description = "The number of days to retain log events for the Lambda function"
  type        = number
  default     = 1
}

# optional variables

variable "memory" {
  description = "The amount of memory in MB allocated to the Lambda function"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The amount of time in seconds that Lambda allows a function to run before stopping it"
  type        = number
  default     = 5
}

variable "concurrent_executions" {
  description = "The amount of reserved concurrent executions for this Lambda function"
  type        = number
  default     = -1
}

variable "layers" {
  description = "The list of Lambda Layer Version ARNs (maximum of 5) to attach to the Lambda function"
  type        = list(string)
  default     = []
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key used to encrypt environment variables"
  type        = string
  default     = null
}

variable "publish_function" {
  description = "Whether to publish the Lambda function"
  type        = bool
  default     = false
}

variable "alias" {
  description = "The alias name for the function. Required when publish_function is true."
  type        = string
  default     = null
  validation {
    condition     = !var.publish_function || var.alias != null
    error_message = "The 'alias' variable is required when 'publish_function' is true."
  }
}

variable "environment_variables" {
  description = "Environment variables to set for the Lambda function"
  type        = map(string)
  default     = {}
}

# tags
variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
  validation {
    condition = contains(keys(var.tags), "Repository")
    error_message = "The 'Repository' tag is mandatory."
  }
}