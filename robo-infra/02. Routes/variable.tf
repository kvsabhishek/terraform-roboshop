variable "project_name" {
  default = "roboshop"
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
