resource "aws_dynamodb_table" "basic-db-table" {
  name           = "Votes"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "ElectionTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "ElectionTitle"
    type = "S"
  }

  attribute {
    name = "Number_of_Votes"
    type = "N"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  global_secondary_index {
    name               = "Election_Vote"
    hash_key           = "ElectionTitle"
    range_key          = "Number_of_Votes"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }

}