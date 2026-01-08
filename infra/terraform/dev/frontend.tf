########################################
# Frontend (CloudFront + S3)
########################################
module "frontend" {
  source = "../modules/frontend"

  app_name     = var.app_name
  environment  = var.environment

  # Optional custom bucket name (keep null to auto-generate inside module)
  bucket_name = var.frontend_bucket_name

  # CloudFront alternate domain names (root + app subdomain)
  aliases = [
    var.domain_name,
    "app.${var.domain_name}"
  ]

  # IMPORTANT: CloudFront ACM certificate must be from us-east-1
  acm_certificate_arn = module.acm_cloudfront.certificate_arn

  # Optional tuning
  enable_ipv6   = var.enable_ipv6
  price_class   = var.price_class
  spa_routing   = true

  # Optional CloudFront Function (viewer-request) based router
  enable_domain_router_function = false

  tags = local.common_tags
}
