module "frontend" {
  source = "../modules/frontend"

  app_name    = var.app_name
  environment = var.environment
  domain_name = var.domain_name

  bucket_name = var.frontend_bucket_name

  # Root + app subdomain on SAME distribution
  aliases = [
    var.domain_name,
    local.app_fqdn
  ]

  acm_certificate_arn = module.acm_cloudfront.certificate_arn

  enable_ipv6                   = var.enable_ipv6
  price_class                   = var.price_class
  spa_routing                   = var.spa_routing
  enable_domain_router_function = var.enable_domain_router_function

  tags = local.common_tags
}
