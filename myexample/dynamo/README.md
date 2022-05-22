# Create lock table from dynamo folder
# once table is create update the backend configuraytion

terraform {
    backend "s3" {
        bucket = "my-s3-bucket"
        key    = "terraform/remote/s3/terraform.tfstate"
        region     = "us-east-1"
       dynamodb_table  = "<name of table like "lock-table">" 
    }
} 

## Add line to existing backend config
dynamodb_table  = "<name of table like "lock-table">" 