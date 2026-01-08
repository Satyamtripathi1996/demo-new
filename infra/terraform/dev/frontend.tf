# Frontend (S3 + CloudFront)
# Hosts:
# - root domain:      example.com
# - app subdomain:    app.example.com
# Both on the SAME CloudFront distribution using aliases.

module "frontend" {
  source = "../modules/frontend"

  app_name     = var.app_name
  environment  = var.environment

  # Optional: provide a custom bucket name, else module will auto-generate one.
  bucket_name = var.frontend_bucket_name

  # Root + app subdomain on SAME distribution
  aliases = [
    var.domain_name,
    "app.${var.domain_name}"
  ]

  # IMPORTANT: CloudFront cert must be in us-east-1
  acm_certificate_arn = module.acm_cloudfront.certificate_arn

  enable_ipv6                 = var.enable_ipv6
  price_class                 = var.price_class
  spa_routing                 = var.spa_routing
  enable_domain_router_function = var.enable_domain_router_function

  tags = local.common_tags
}
