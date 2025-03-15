output "certificate_arn" {
  description = "ARN of the ACM wildcard certificate"
  value       = aws_acm_certificate.wildcard_cert.arn
}
