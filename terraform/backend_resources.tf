terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.aws_region

}
variable "aws_region" {
  description = "the aws region to deploy the resources"
  type        = string
  default     = "us-east-2"
}
#s3 bucket to store the terraform state file
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "zero-touch-iac-tfstate-stacky-2026"
  force_destroy = true

  tags = {
    Name        = "Terraform State Storage"
    Environment = "DevOps"

  }
}
# Enable Versioning for State Rollbacks
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Server-Side Encryption for Security
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "zero-touch-iac-tf-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "DevOps"
  }
}
