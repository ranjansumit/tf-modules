/*output "rest_api_invoke_url" {
  value       = join("", aws_api_gateway_rest_api.example.execution_arn)
  description = "The Execution ARN of the REST API."
}*/


output "nlb_arn" {
  description = "The ARN of the NLB"
  value       =  module.default_nlb.lb_arn
}