variable "environment" {
    default = "sandbox"
    type = string
}
variable "CreatedBy" {
    default = "bpsappterraform"
    type = string
}
variable "owner" {
    default = "bpsdevops"
}
variable "region_name" {
    default = "us-east-1"
    type = string
}
variable "ecr_enable" {
    default = true
    type = bool
}
variable "image_names" {
  type        = any
  default     = {
                  repo1: {name:"bps-pdf-services-iva-dev",policy:"full_access_policy"},
                  repo2: {name:"bpsapps-lambda-source-iva-dev",policy:"read_policy"}
                  }
  description = "List of Docker local image names, used as repository names for AWS ECR "
}


variable "full_access_policy" {
  description = "ECR full access policy"
  type        = string
  default     = <<POLICY
  {
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
POLICY
}

variable "read_policy" {
  description = "ECR read only policy"
  type        = string
  default     = <<POLICY
  {
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
POLICY
}
















# General vars
variable "name" {
  description = "Name of the repository."
  type        = string
  default     = "ecr"
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`."
  type        = string
  default     = "MUTABLE"
}

# Image scanning configuration
variable "image_scanning_configuration" {
  description = "Configuration block that defines image scanning configuration for the repository. By default, image scanning must be manually triggered. See the ECR User Guide for more information about image scanning."
  type        = map
  default     = {}
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  type        = bool
  default     = true
}

# Timeouts
variable "timeouts" {
  description = "Timeouts map."
  type        = map
  default     = {}
}

variable "timeouts_delete" {
  description = "How long to wait for a repository to be deleted."
  type        = string
  default     = null
}


# Lifecycle policy
variable "lifecycle_policy" {
  description = "Manages the ECR repository lifecycle policy"
  type        = string
  default     = <<POLICY
  {
  "rules": [
    {
      "rulePriority": 1,
      "description": "Remove untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Rotate images when reach 100 images stored",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 100
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
POLICY
}

# Tags
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# Encryption type
variable "encryption_type" {
  description = "The encryption type to use for the repository. Valid values are `AES256` or `KMS`"
  type        = string
  default     = "AES256"
}

# KMS key
variable "kms_key" {
  description = "The ARN of the KMS key to use when encryption_type is `KMS`. If not specified when encryption_type is `KMS`, uses a new KMS key. Otherwise, uses the default AWS managed key for ECR."
  type        = string
  default     = null
}
