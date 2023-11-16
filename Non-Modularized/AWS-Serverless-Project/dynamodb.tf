resource "aws_dynamodb_table" "Student-Details-db" {
  name           = var.db_table_name
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "ID"

  attribute {
    name = "ID"
    type = "S"
  }

  tags = {
    Name = "Production-DB"
  }
}