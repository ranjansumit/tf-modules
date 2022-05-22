resource "aws_dynamodb_table" "state_locking" {
  hash_key = "LockID"
  name     = var.name
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
