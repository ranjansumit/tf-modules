variable "create" {
  description = "Whether to create SQS queue"
  type        = bool
  default     = true
}

variable "name" {
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "A unique name beginning with the specified prefix."
  type        = string
  default     = null
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)"
  type        = number
  default     = 30
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)"
  type        = number
  default     = 345600
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB)"
  type        = number
  default     = 262144
}

variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes)"
  type        = number
  default     = 0
}

variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds)"
  type        = number
  default     = 0
}

variable "policy" {
  description = "The JSON policy for the SQS queue"
  type        = string
  default     = ""
}

variable "redrive_policy" {
  description = "The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string (\"5\")"
  type        = string
  default     = ""
}

variable "redrive_allow_policy" {
  description = "The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs."
  type        = string
  default     = ""
}

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = false
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "kms_data_key_reuse_period_seconds" {
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours)"
  type        = number
  default     = 300
}

variable "deduplication_scope" {
  description = "Specifies whether message deduplication occurs at the message group or queue level"
  type        = string
  default     = null
}

variable "fifo_throughput_limit" {
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "queue_map" {
  description = "A mapping of all queues to create sqs"
  type        = any
  default     = {
                    "queue1" = {"name":"DocumentIntakeDeadLetter-sandbox",
                    "visibility_timeout_seconds":"900",
                    "max_message_size":"262144",
                    "message_retention_seconds":"1209600",
                    "delay_seconds":"0",
                    "receive_wait_time_seconds":"20",
                    "kms_master_key_id":"alias/aws/sqs",
                    "tags" : {}
                    },
                    
                    "queue2" ={"name":"DocumentIntake-sandbox",
                    "visibility_timeout_seconds":"900",
                    "max_message_size":"262144",
                    "message_retention_seconds":"1209600",
                    "delay_seconds":"0",
                    "receive_wait_time_seconds":"20",
                    "kms_master_key_id":"alias/aws/sqs"
                    "redrive_policy": "{ \"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:516852271566:DocumentIntakeDeadLetter-sandbox\", \"maxReceiveCount\" : 4}"
                    "depends_on_dlq": true
                    "dlq_name":"queue1"
                    "tags":{}
                    }
                    "queue3" ={"name":"PplusAgentIngestionQueue-sandbox.fifo",
                    "visibility_timeout_seconds":"300",
                    "max_message_size":"262144",
                    "message_retention_seconds":"1209600",
                    "delay_seconds":"0",
                    "receive_wait_time_seconds":"20",
                    "kms_master_key_id":"alias/aws/sqs"
                    "fifo_queue":true
                    "content_based_deduplication":true
                    "tags":{}
                    "policy":<<POLICY
                    {
                        "Version": "2012-10-17",
                        "Id": "sqspolicy",
                        "Statement": [
                            {
                                "Action": [
                                    "SQS:ChangeMessageVisibility",
                                    "SQS:ReceiveMessage",
                                    "SQS:DeleteMessage"
                                ],
                                "Effect": "Allow",
                                "Resource": "*",
                                "Principal": "*"
                            }
                        ]
                    }
                    POLICY
                },
                "queue4" ={"name":"PplusRetryTransactionQueue-sandbox.fifo",
                    "visibility_timeout_seconds":"300",
                    "max_message_size":"262144",
                    "message_retention_seconds":"1209600",
                    "delay_seconds":"0",
                    "receive_wait_time_seconds":"20",
                    "kms_master_key_id":"alias/aws/sqs"
                    "fifo_queue":true
                    "content_based_deduplication":true
                    "tags":{}
                    "policy":<<POLICY
                    {
                        "Version": "2012-10-17",
                        "Id": "sqspolicy",
                        "Statement": [
                            {
                                "Action": [
                                    "SQS:ChangeMessageVisibility",
                                    "SQS:ReceiveMessage",
                                    "SQS:DeleteMessage"
                                ],
                                "Effect": "Allow",
                                "Resource": "*",
                                "Principal": "*"
                            }
                        ]
                    }
                    POLICY
                },
                "queue5" ={"name":"PplusAgentIngestionResponseQueue-sandbox.fifo",
                    "visibility_timeout_seconds":"300",
                    "max_message_size":"262144",
                    "message_retention_seconds":"1209600",
                    "delay_seconds":"0",
                    "receive_wait_time_seconds":"20",
                    "kms_master_key_id":"alias/aws/sqs"
                    "fifo_queue":true
                    "content_based_deduplication":true
                    "tags":{}
                    "policy":<<POLICY
                    {
                        "Version": "2012-10-17",
                        "Id": "sqspolicy",
                        "Statement": [
                            {
                                "Action": [
                                    "SQS:ChangeMessageVisibility",
                                    "SQS:ReceiveMessage",
                                    "SQS:DeleteMessage"
                                ],
                                "Effect": "Allow",
                                "Resource": "*",
                                "Principal": "*"
                            }
                        ]
                    }
                    POLICY
                }
        }
}

variable "region_name" {
    default="us-east-1"
}

variable "depends_on_dlq" {
  description = "If dlq needs to be created before queue"
  type        = bool
  default     = false
}

variable "dlq_name" {
  description = "name of the dlq"
  type        = string
  default     = ""
}

variable "dlq_arn" {
  description = "ARN of the dlq"
  type        = string
  default     = ""
}