resource "aws_sns_topic" "image-rekognition-sns" {
  name = var.sns-name
}

resource "aws_sns_topic_subscription" "image-rekognition-sns-subscription" {
  topic_arn = aws_sns_topic.image-rekognition-sns.arn
  protocol  = "email"
  endpoint  = var.mail-id
}