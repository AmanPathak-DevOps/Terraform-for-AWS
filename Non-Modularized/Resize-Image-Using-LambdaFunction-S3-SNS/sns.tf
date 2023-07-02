# Creating SNS Topic to notify the concerned person when the Image has been resized 
resource "aws_sns_topic" "Resized-Image-SNS" {
  name = var.sns-name
}

# Adding email endpoint to concerned person will get notification via email
resource "aws_sns_topic_subscription" "Resized-Image-SNS-Subscription" {
  topic_arn = aws_sns_topic.Resized-Image-SNS.arn
  protocol  = "email"
  endpoint  = var.mail-id
}