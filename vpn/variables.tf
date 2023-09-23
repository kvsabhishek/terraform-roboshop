variable "vpc1_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc2_cidr" {
  default = "172.0.0.0/16"
}

variable "vpc1_public_cidr" {
  default = "10.0.1.0/24"
}

variable "vpc2_public_cidr" {
  default = "172.0.1.0/24"
}

variable "vpc2_private_cidr" {
  default = "172.0.2.0/24"
}   
