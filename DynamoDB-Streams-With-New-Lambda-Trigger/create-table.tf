resource "aws_dynamodb_table" "dynamodb-table" {
  name             = "GameScore"
  billing_mode     = "PROVISIONED"
  read_capacity    = 5
  write_capacity   = 5
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  hash_key         = "Name"
  range_key        = "Score"
  attribute {
    name = "Name"
    type = "S"
  }

  attribute {
    name = "Score"
    type = "N"
  }
}