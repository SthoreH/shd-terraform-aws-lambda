provider "aws" {
  region  = "sa-east-1"
}

terraform {
  required_version = "1.14.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.40.0"
    }
  }
}