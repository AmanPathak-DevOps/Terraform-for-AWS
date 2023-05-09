resource "aws_acm_certificate" "cert" {
  provider = aws.use_default_region
  domain_name               = "*.${var.domain_simple_name}"
  validation_method         = "DNS"
  subject_alternative_names = [var.domain_simple_name]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert" {
  provider = aws.use_default_region
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}