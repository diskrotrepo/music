resource "aws_route53_record" "subdomain_records" {
  for_each = toset(var.subdomains)

  zone_id = var.hosted_zone_id
  name    = "${each.key}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.load_balancer_dns
    zone_id                = var.load_balancer_zone_id
    evaluate_target_health = false
  }
}


