variable "aws_region" { type = string }
variable "environment" { type = string }
variable "app_name" { type = string }
variable "domain_name" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}

# Networking
variable "vpc_cidr" { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }

# Route53
variable "create_hosted_zone" {
  type    = bool
  default = true
}

variable "existing_zone_id" {
  type    = string
  default = null
}

# Backend app
variable "app_port" {
  type    = number
  default = 8000
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

# RDS
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}

# Buckets
variable "uploads_bucket_name" {
  description = "S3 bucket used by backend to store user uploads/files"
  type        = string
}

# ECR image tag
variable "api_image_tag" {
  description = "Docker tag to deploy"
  type        = string
  default     = "latest"
}
