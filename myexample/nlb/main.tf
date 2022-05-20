provider "aws"{
  region ="us-east-1"
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