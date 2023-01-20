
# Attaching Target Groups to EC2
resource "aws_lb_target_group_attachment" "TG-Attachment" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.EC2-One.id
  port             = 80
}


# Attaching Target Groups to EC2-Two
resource "aws_lb_target_group_attachment" "TG-Attachment2" {
  target_group_arn = aws_lb_target_group.TG.arn
  target_id        = aws_instance.EC2-Two.id
  port             = 80
}

