terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }

  backend "s3" {
    bucket         = "robo-infra-remote"
    key            = "vpc"
    dynamodb_table = "robo-infra-remote-state-lock"
    region         = "us-east-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
