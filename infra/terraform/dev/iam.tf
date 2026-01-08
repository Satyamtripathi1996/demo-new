########################################
# IAM (roles/policies for ECS, etc.)
########################################
module "iam" {
  source = "../modules/iam"

  app_name     = var.app_name
  environment  = var.environment

  # Give ECS task role access to the uploads bucket
  s3_bucket_arns = [
    module.uploads_bucket.bucket_arn
  ]

  # Optional: secrets your ECS task should read
  secrets_arns = var.secrets_arns

  tags = local.common_tags
}
