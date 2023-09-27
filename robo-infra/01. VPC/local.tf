locals {
  vpc_list = tolist(keys(var.vpc_cidrs))
}
