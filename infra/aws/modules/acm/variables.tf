variable "domain_name" {
  description = "Primary domain name for the certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional SANs for the certificate"
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID for DNS validation"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the ACM certificate"
  type        = map(string)
  default     = {}
}
