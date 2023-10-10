variable "project" {
  default = "roboshop"
}

variable "vpc1_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc2_cidr" {
  default = "172.0.0.0/16"
}

variable "vpc1_public_subnet_count" {
  default = 2
}

variable "vpc1_private_subnet_count" {
  default = 2
}

variable "vpc1_database_subnet_count" {
  default = 2
}

variable "vpc2_public_subnet_count" {
  default = 2
}

variable "vpc2_private_subnet_count" {
  default = 2
}

variable "vpc2_database_subnet_count" {
  default = 2
}

variable "vpc1_public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc1_private_subnet_cidrs" {
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "vpc1_database_subnet_cidrs" {
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "vpc2_public_subnet_cidrs" {
  default = ["172.0.1.0/24", "172.0.2.0/24"]
}

variable "vpc2_private_subnet_cidrs" {
  default = ["172.0.3.0/24", "172.0.4.0/24"]
}

variable "vpc2_database_subnet_cidrs" {
  default = ["172.0.5.0/24", "172.0.6.0/24"]
}


variable "common_tags" {
  default = {
    "Terraform" = true
  }
}
