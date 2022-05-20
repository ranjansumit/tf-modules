output "sqs_arn" {
  description = "The ARN of the sqs"
  value       =  module.mysqs_dlq["queue1"].sqs_queue_arn 
}

output "PplusAgentIngestionQueueArn"{
  description = "The ARN of the PplusAgentIngestionQueue"
  value       =  module.mysqs_dlq["queue5"].sqs_queue_arn

}

output "PplusAgentIngestionQueueUrl"{
  description = "The URL of the PplusAgentIngestionQueue"
  value       =  module.mysqs_dlq["queue5"].sqs_queue_id
}
