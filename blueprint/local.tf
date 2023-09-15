locals {
  list_of_public_subnets = values(aws_subnet.public)
}

# output "list_of_public_subnets" {
#   value = local.list_of_public_subnets[0]
# }
