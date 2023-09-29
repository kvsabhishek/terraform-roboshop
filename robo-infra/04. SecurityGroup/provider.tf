terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }

  backend "s3" {
    bucket         = "robo-infra-remote" #S3 Bucket name
    key            = "sg"
    region         = "us-east-1"
    dynamodb_table = "robo-infra-remote-state-lock" #Name of DynamoDB table
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
