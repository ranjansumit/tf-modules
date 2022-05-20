variable "env" {
  type    = map(any)
  default = {}
}
#
# AWS Backup vault
#
variable "vault_name" {
  description = "Name of the backup vault to create. If not given, AWS use default"
  type        = string
  default     = "myvault"
}

variable "vault_kms_key_arn" {
  description = "The server-side encryption key that is used to protect your backups"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {
    Owner       = "devops"
    Environment = "prod"
    Terraform   = true
  }
}

variable "backup_policy"{
  description = "The Vault backup policy to assign"
  type = string 
  default = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "default",
  "Statement": [
    {
      "Sid": "default1",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "backup:DescribeBackupVault",
        "backup:PutBackupVaultNotifications"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}
#
# AWS Backup plan
#
variable "plan_name" {
  description = "The display name of a backup plan"
  type        = string
  default     = "myplan"
}

# Default rule
variable "rule_name" {
  description = "An display name for a backup rule"
  type        = string
  default     = "myrule1"
}

variable "rule_schedule" {
  description = "A CRON expression specifying when AWS Backup initiates a backup job"
  type        = string
  default     = "cron(0 12 * * ? *)"
}

variable "rule_start_window" {
  description = "The amount of time in minutes before beginning a backup"
  type        = number
  default     = 120
}

variable "rule_completion_window" {
  description = "The amount of time AWS Backup attempts a backup before canceling the job and returning an error"
  type        = number
  default     = 360
}

variable "rule_recovery_point_tags" {
  description = "Metadata that you can assign to help organize the resources that you create"
  type        = map(string)
  default     = {Environment = "prod"}
}

# Rule lifecycle
variable "rule_lifecycle_cold_storage_after" {
  description = "Specifies the number of days after creation that a recovery point is moved to cold storage"
  type        = number
  default     = null
}

variable "rule_lifecycle_delete_after" {
  description = "Specifies the number of days after creation that a recovery point is deleted. Must be 90 days greater than `cold_storage_after`"
  type        = number
  default     = 30
}

# Rule copy action
variable "rule_copy_action_lifecycle" {
  description = "The lifecycle defines when a protected resource is copied over to a backup vault and when it expires."
  type        = map(any)
  default     = {}
}

variable "rule_copy_action_destination_vault_arn" {
  description = "An Amazon Resource Name (ARN) that uniquely identifies the destination backup vault for the copied backup."
  type        = string
  default     = null
}

variable "rule_enable_continuous_backup" {
  description = " Enable continuous backups for supported resources."
  type        = bool
  default     = false
}


# Rules
variable "rules" {
  description = "A list of rule maps"
  type        = any
  default     = ["rule1"]
}

# Selection
variable "selection_name" {
  description = "The display name of a resource selection document"
  type        = string
  default     = "myselection1"
}

variable "selection_resources" {
  description = "An array of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to assign to a backup plan"
  type        = list(any)
  default     = []
}

variable "selection_not_resources" {
  description = "An array of strings that either contain Amazon Resource Names (ARNs) or match patterns of resources to exclude from a backup plan."
  type        = list(any)
  default     = []
}

variable "selection_conditions" {
  description = "A map of conditions that you define to assign resources to your backup plans using tags."
  type        = map(any)
  default     = {}
}

variable "selection_tags" {
  description = "List of tags for `selection_name` var, when using variable definition."
  type        = list(any)
  default     = [
        {
          type  = "STRINGEQUALS"
          key   = "Environment"
          value = "production"
        },
        {
          type  = "STRINGEQUALS"
          key   = "Owner"
          value = "devops"
        }
      ]
}

# Selection
variable "selections" {
  description = "A list of selction maps"
  type        = any
  default     = []
}

variable "enabled" {
  description = "Change to false to avoid deploying any AWS Backup resources"
  type        = bool
  default     = true
}

# Windows Backup parameter
variable "windows_vss_backup" {
  description = "Enable Windows VSS backup option and create a VSS Windows backup"
  type        = bool
  default     = false
}

#
# Notifications
#
variable "notifications" {
  description = "Notification block which defines backup vault events and the SNS Topic ARN to send AWS Backup notifications to. Leave it empty to disable notifications"
  type        = any
  default     = {}
}

#
# IAM
#
variable "iam_role_arn" {
  description = "If configured, the module will attach this role to selections, instead of creating IAM resources by itself"
  type        = string
  default     = null
}


variable "backup_tag_policy"{
  description = "The backup tag policy to assign"
  type = string 
  default = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "backup:TagResource",
            "backup:ListTags",
            "backup:UntagResource",
            "tag:GetResources"
        ],
        "Resource": "*"
    }
  ]
}
POLICY
}

variable "assume_role_policy"{
  description = "The assume_role_policy for ab_role"
  type = string 
  default = <<POLICY
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}