resource "aws_sns_topic" "sns-topic" {
    count = "${var.is_sns_enable == 1 ?  var.sns_topic_count : 0 }"

    name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "sns-subscription" {
    count = "${var.is_sns_enable == 1 && var.is_sns_subscription_enable == 1 ? var.sns_subscription_count : 0 }"

    topic_arn = aws_sns_topic.sns-topic[count.index].arn
    protocol = var.protocol_sns_subscription
    endpoint = var.endpoint_protocol
}