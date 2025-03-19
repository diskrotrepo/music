output "table_names" {
  value = { for key, table in aws_dynamodb_table.this : key => table.name }
}

output "table_arns" {
  value = { for key, table in aws_dynamodb_table.this : key => table.arn }
}
