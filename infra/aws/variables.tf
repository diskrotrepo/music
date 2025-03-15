
variable "profile" {
  description = "The AWS profile ID."
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources."
  type        = string
}

variable "project" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The name of the environment."
  type        = string
}

variable "route53_zone_id" {
  description = "The Route53 zone ID."
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "subdomain" {
  description = "The subdomain to create in Route53"
  type        = string
}
