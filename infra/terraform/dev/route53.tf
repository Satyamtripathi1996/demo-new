########################################################
# Route53
# - Phase 1: Create/Use Hosted Zone (NO records)
# - Phase 2: Create DNS records after ALB/CloudFront exist
########################################################

module "route53_zone" {
  source = "../modules/route53"

  create_zone  = var.create_hosted_zone
  zone_id      = var.existing_zone_id
  domain_name  = var.domain_name
  tags         = local.common_tags

  # IMPORTANT: Keep records disabled here to avoid dependency cycles
  create_api_record        = false
  create_frontend_records  = false
  create_docs_record       = false
}

module "route53_records" {
  source = "../modules/route53"

  create_zone  = false
  zone_id      = module.route53_zone.hosted_zone_id
  domain_name  = var.domain_name
  tags         = local.common_tags

  # API -> ALB
  create_api_record  = true
  api_alb_dns_name   = module.alb.alb_dns_name
  api_alb_zone_id    = module.alb.alb_zone_id

  # root + app -> Frontend CloudFront
  create_frontend_records        = true
  frontend_cloudfront_domain_name = module.frontend.cloudfront_domain_name
  frontend_cloudfront_zone_id     = module.frontend.cloudfront_hosted_zone_id

  # docs -> Docs CloudFront
  create_docs_record          = true
  docs_cloudfront_domain_name = module.docs.cloudfront_domain_name
  docs_cloudfront_zone_id     = module.docs.cloudfront_hosted_zone_id
}
