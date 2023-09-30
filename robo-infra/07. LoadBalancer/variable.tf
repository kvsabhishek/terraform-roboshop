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

variable "lb" {
  default = {
    "Public_ALB"  = "public",
    "Private_ALB" = "private"
  }
}
variable "api_tier_components" {
  default = ["catalouge", "cart", "user", "shipping", "payment", "rating"]
}

variable "db_tier_components" {
  default = ["mongodb", "redis", "mysql", "rabbitmq"]
}
