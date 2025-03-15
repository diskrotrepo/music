output "distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.id
}

output "distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "hosted_zone_id" {
  description = "The Zone ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn.hosted_zone_id
}
