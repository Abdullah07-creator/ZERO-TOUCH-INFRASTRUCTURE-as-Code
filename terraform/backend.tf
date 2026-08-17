terraform {
  backend "s3" {
    bucket         = "zero-touch-iac-tfstate-stacky-2026"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "zero-touch-iac-tf-locks"
    encrypt        = true
  }
}
