############################################
# IAM (roles/policies needed by ECS, etc.)
############################################

module "iam" {
  source = "../modules/iam"

  app_name     = var.app_name
  environment  = var.environment

  # If your IAM module attaches S3 permissions, keep this.
  # If your iam module doesn't have this variable, remove these two lines.
  uploads_bucket_arn  = module.uploads_bucket.bucket_arn

  tags = local.common_tags
}
