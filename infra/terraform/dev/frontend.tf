module "frontend" {
  source = "../modules/frontend"

  app_name     = var.app_name
  environment  = var.environment

  # Optional custom bucket name (must be globally unique).
  # If you don't want custom, keep your terraform.tfvars value as null.
  bucket_name = var.frontend_bucket_name

  # Root + app subdomain on SAME CloudFront distribution
  aliases = [
    var.domain_name,
    "app.${var.domain_name}",
  ]

  # IMPORTANT: CloudFront ACM certificate must be from us-east-1 (your acm_cloudfront module)
  acm_certificate_arn = module.acm_cloudfront.certificate_arn

  enable_ipv6                   = var.enable_ipv6
  price_class                   = var.price_class
  spa_routing                   = var.spa_routing
  enable_domain_router_function = var.enable_domain_router_function

  tags = local.common_tags
}
