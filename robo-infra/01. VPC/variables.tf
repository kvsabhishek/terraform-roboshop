variable "project_name" {
  default = "roboshop"
}

variable "vpc_cidrs" {
  type    = map(string)
  default = { "vpc-1" = "10.0.0.0/16", "vpc-2" = "172.0.0.0/16" }

  validation {
    condition     = length(var.vpc_cidrs) < 3
    error_message = "You are allowed to create only 2 VPC's"
  }
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  default = {
    Project   = "Roboshop",
    Terraform = "True"
  }
}

variable "vpc1_subnet_cidrs" {
  default = { public = "10.0.1.0/24",
  private = "10.0.2.0/24" }
}

variable "vpc2_subnet_cidrs" {
  default = { public = "172.0.1.0/24",
    private = "172.0.2.0/24",
  database = "172.0.3.0/24" }
}
