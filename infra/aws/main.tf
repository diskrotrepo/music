

module "s3_wav_bucket" {
  source             = "./modules/s3"
  bucket_name        = var.bucket_name
  versioning_enabled = false
  enable_encryption  = false
  public_site        = true

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

module "wav_cert" {
  source          = "./modules/acm"
  domain_name     = "${var.subdomain}.${var.domain_name}"
  route53_zone_id = var.route53_zone_id

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

module "music_cloudfront" {
  source              = "./modules/cloudfront"
  bucket_name         = module.s3_wav_bucket.bucket_name
  acm_certificate_arn = module.wav_cert.certificate_arn
  aliases             = ["${var.subdomain}.${var.domain_name}"]

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

module "wav_route53" {
  source                = "./modules/route53"
  domain_name           = var.domain_name
  load_balancer_dns     = module.music_cloudfront.distribution_domain_name
  load_balancer_zone_id = module.music_cloudfront.hosted_zone_id
  subdomains            = [var.subdomain]
  hosted_zone_id        = var.route53_zone_id
}
