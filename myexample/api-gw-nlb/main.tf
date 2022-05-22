provider "aws" {
  region = var.region_name
}

module default_nlb {
  source= "../../mymodules/nlb"
  name               = var.name
  load_balancer_type = var.load_balancer_type
  subnets = var.subnets
  #target_groups = var.target_groups
  http_tcp_listeners = var.http_tcp_listeners
  default_action_type             = var.default_action_type
  target_group_arn = var.target_group_arn

}
module myapigw {

  source= "../../mymodules/api-gw"
  rest_api_name         = var.rest_api_name
  vpc_endpoint_ids      = var.vpc_endpoint_ids
  rest_api_type         = var.rest_api_type
  rest_api_policy       = var.rest_api_policy
  rest_api_tags         = var.rest_api_tags

  #auth
  auth_provider_arns    = var.auth_provider_arns
  auth_name             = var.auth_name
  auth_type             = var.auth_type
  auth_identity_source  = var.auth_identity_source
  

  #Gateway Resource
  resource_path_part    = var.resource_path_part
  sub_resource_path_part= var.sub_resource_path_part
  method_variables      = var.method_variables

  # Deployment Stage
  deployment_stage_name = var.deployment_stage_name
  deployment_variables  = var.deployment_variables
  method_resource_path  = var.method_resource_path
  method_http_method    = var.method_http_method

  #VPC Link
  vpc_link_name = var.vpc_link_name
  nlb_arn       = [module.default_nlb.lb_arn]

}


