module "sns-topic" {
  source = "../Modules/Terraform-SNS"

  is_sns_enable   = var.is_enable
  sns_topic_count = 1
  sns_topic_name  = var.topic_name

  is_sns_subscription_enable = var.is_subscription_enable
  sns_subscription_count     = 1
  protocol_sns_subscription  = var.protocol_subscription
  endpoint_protocol          = var.endpoint
}