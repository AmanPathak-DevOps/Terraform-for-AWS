resource "aws_sqs_queue" "sqs-queue" {
  name                      = "New-SQS"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0

  tags = {
    Environment = "Dev"
  }
}