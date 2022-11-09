resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn  = aws_dynamodb_table.dynamodb-table.stream_arn
  function_name     = data.aws_lambda_function.existing.arn
  starting_position = "LATEST"
}


data "aws_lambda_function" "existing" {
  function_name = "dynamodb-stream-lambda"
}