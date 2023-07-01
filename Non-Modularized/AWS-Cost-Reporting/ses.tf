resource "aws_ses_email_identity" "send-mail" {
  email = "mailid@gmail.com"
}

resource "aws_ses_email_identity" "receiver-mail" {
  email = "mailid@gmail.com"
}


