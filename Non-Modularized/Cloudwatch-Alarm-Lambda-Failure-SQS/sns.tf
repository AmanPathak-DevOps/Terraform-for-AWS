# Creating SNS Topic
resource "aws_sns_topic" "topic-sns" {
  name = "sns-topic-for-S3"
}

# Creating Subscription for the SNS Topics
resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.topic-sns.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs-queue.arn
}