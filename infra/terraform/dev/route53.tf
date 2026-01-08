#############################################
# Route53
# - Creates/uses hosted zone for the root domain
# - Creates DNS records:
#     api.<domain>   -> ALB
#     <domain>       -> Frontend CloudFront
#     app.<domain>   -> Frontend CloudFront
#     docs.<domain>  -> Docs CloudFront
#############################################

# 1) Hosted zone only (no records here to avoid dependency cycles)
module "route53_zone" {
  source = "../modules/route53"

  # Create a new hosted zone OR use an existing one
  create_zone = var.create_hosted_zone
  zone_id     = var.existing_zone_id
  domain_name = var.domain_name

  # IMPORTANT: no records in this call
  create_api_record        = false
  create_frontend_records  = false
  create_docs_record       = false

  tags = local.common_tags
}

# 2) Records only (use the zone from above)
module "route53_records" {
  source = "../modules/route53"

  create_zone = false
  zone_id     = module.route53_zone.hosted_zone_id
  domain_name = var.domain_name

  # API -> ALB (api.<domain>)
  create_api_record = true
  api_alb_dns_name  = module.alb.alb_dns_name
  api_alb_zone_id   = module.alb.alb_zone_id

  # Frontend -> CloudFront (<domain> + app.<domain>)
  create_frontend_records        = true
  frontend_cloudfront_domain_name = module.frontend.cloudfront_domain_name
  frontend_cloudfront_zone_id     = module.frontend.cloudfront_hosted_zone_id

  # Docs -> CloudFront (docs.<domain>)
  create_docs_record          = true
  docs_cloudfront_domain_name = module.docs.cloudfront_domain_name
  docs_cloudfront_zone_id     = module.docs.cloudfront_hosted_zone_id

  tags = local.common_tags
}
