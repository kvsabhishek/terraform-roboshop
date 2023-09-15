variable "vpc_name" {
  default = "roboshop-vpc"
}

variable "vpc_cidr" {
  default = ["10.0.0.0/16"]
}

variable "public_subnet" {
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
}

