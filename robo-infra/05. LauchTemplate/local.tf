locals {
  components = concat(var.api_tier_components, var.db_tier_components)
}

