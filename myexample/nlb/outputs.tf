
output "nlb_arn" {
  description = "The ARN of the NLB"
  value       =  module.default_nlb.lb_arn
}