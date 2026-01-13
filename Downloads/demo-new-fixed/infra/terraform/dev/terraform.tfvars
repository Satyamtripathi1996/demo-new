aws_region   = "ap-south-1"
environment  = "dev"
app_name     = "vursa"

domain_name        = "vursa.dev"
create_hosted_zone = false
existing_zone_id   = "Z07384293LTZ2OHY95IXM"

tags = {
  Project = "vursa"
  Env     = "dev"
}

vpc_cidr             = "10.10.0.0/16"
public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
private_subnet_cidrs = ["10.10.11.0/24", "10.10.12.0/24"]

app_port          = 8000
health_check_path = "/health"

db_name     = "vursa"
db_username = "vursaadmin"
db_password = "REPLACE_WITH_STRONG_PASSWORD"

uploads_bucket_name  = "vursa-user-docs-dev-etop-9f3a12"
api_image_tag        = "latest"

frontend_bucket_name = "vursa-frontend-dev"
docs_bucket_name     = "vursa-docs-dev"
