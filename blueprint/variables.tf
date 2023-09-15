variable "project_name" {

}

variable "vpc_cidr" {
}

variable "public_subnet" {
  type = map(any)
  validation {
    condition     = length(var.public_subnet) <= 2
    error_message = "Cannot create more than 2 public subnets"
  }
}

variable "private_subnet" {
  type = map(any)
  validation {
    condition     = length(var.private_subnet) <= 2
    error_message = "Cannot create more than 2 private subnets"
  }
}

variable "common_tags" {
  default = {}
}
