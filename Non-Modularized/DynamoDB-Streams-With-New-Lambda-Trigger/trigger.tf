resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn  = aws_dynamodb_table.dynamodb-table.stream_arn
  function_name     = aws_lambda_function.lambda-function.arn
  starting_position = "LATEST"
}
