module "docs" {
  source = "../modules/docs"

  app_name    = var.app_name
  environment = var.environment
  domain_name = var.domain_name

  acm_certificate_arn = module.acm_cloudfront.certificate_arn
  spa_routing         = true

  tags = local.common_tags
}
