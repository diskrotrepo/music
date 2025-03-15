variable "subdomains" {
  description = "List of subdomains to create A records for"
  type        = list(string)
}

variable "hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID"
  type        = string
}

variable "domain_name" {
  description = "The root domain name"
  type        = string
}

variable "load_balancer_dns" {
  description = "DNS name of the Load Balancer"
  type        = string
}

variable "load_balancer_zone_id" {
  description = "Zone ID of the Load Balancer"
  type        = string
}
