output "subdomain_records" {
  description = "List of created subdomain records"
  value       = [for record in aws_route53_record.subdomain_records : record.fqdn]
}
