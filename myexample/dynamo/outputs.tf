output "state_locking_table_name" {
    description  = "Name of dynamo db table for state lock"
    value = aws_dynamodb_table.state_locking.name
}