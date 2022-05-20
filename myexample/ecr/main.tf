provider "aws" {
  region = var.region_name
}

module "ecr" {
  source              = "../../mymodules/ecr"
  for_each         = var.image_names
  name             = each.value.name
  policy           = try(each.value.policy,null) == "full_access_policy" ? var.full_access_policy : var.read_policy
  tags = {
    owner           = var.owner
    environment     = var.environment
    CreatedBy       = var.CreatedBy
    component       = "ecr"
  }
  #policy                 = var.policy
  lifecycle_policy       = var.lifecycle_policy
}