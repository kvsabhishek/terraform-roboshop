variable "vpc_cidrs" {
  default = { "vpc1" = "10.0.0.0/16",
  "vpc2" = "172.0.0.0/16" }
}

variable "vpc1_public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc1_private_subnets" {
  default = {}
}

variable "vpc1_database_subnets" {
  default = {}
}

variable "vpc2_public_subnets" {
  default = ["172.0.1.0/24", "172.0.2.0/24"]
}

variable "vpc2_private_subnets" {
  default = ["172.0.3.0/24", "172.0.4.0/24"]
}

variable "vpc2_database_subnets" {
  default = ["172.0.5.0/24", "172.0.6.0/24"]
}

variable "common_tags" {
  default = {
    Terraform = true,
    Project   = "Roboshop"
  }
}
