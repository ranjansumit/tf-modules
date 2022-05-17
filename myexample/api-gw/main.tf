provider "aws" {
  region = var.region_name
}
module myapigw {

  source= "../mymodules/api-gw"
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
  nlb_arn       = var.nlb_arn
}

resource "aws_lb_listener" "default" {
  count = length(var.target_group_arn) > 0 ? 1 : 0
  load_balancer_arn = var.nlb_arn[0]

  default_action {
    target_group_arn = var.target_group_arn
    type             = "forward"
  }
}