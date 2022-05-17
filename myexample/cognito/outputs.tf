output "arn" {
  description = "The ARN of the user pool"
  value       = var.enabled ? module.myuserpool.arn : null
}