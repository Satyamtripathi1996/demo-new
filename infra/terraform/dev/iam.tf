#############################################
# IAM module
# - Creates IAM roles/policies needed by ECS tasks (execution/task role etc.)
# - Keep this file ONLY for IAM (no frontend here)
#############################################

module "iam" {
  source = "../modules/iam"

  app_name     = var.app_name
  environment  = var.environment

  tags = local.common_tags
}
