terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
