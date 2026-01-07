module "frontend" {
  source = "../modules/frontend"

  app_name     = var.app_name
  environment  = var.environment

  aliases = [
    var.domain_name,
    "app.${var.domain_name}"
  ]

  acm_certificate_arn = module.acm_cloudfront.certificate_arn
  spa_routing         = true

  enable_domain_router_function = false

  tags = local.common_tags
}
