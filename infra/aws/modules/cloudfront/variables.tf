variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate for SSL"
  type        = string
}

variable "aliases" {
  description = "List of domain aliases (CNAMEs) for the CloudFront distribution"
  type        = list(string)
  default     = []
}

variable "lambda_function_arn" {
  description = "The qualified ARN of the Lambda@Edge function for URL rewriting"
  type        = string
  default     = "" # Optional; if not provided, no Lambda will be associated
}

variable "tags" {
  description = "Tags to apply to the CloudFront distribution"
  type        = map(string)
  default     = {}
}
