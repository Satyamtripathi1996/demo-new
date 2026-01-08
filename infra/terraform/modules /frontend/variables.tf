# Variables for the Frontend module (S3 + CloudFront)

variable "app_name" {
  description = "Application name (used in resource names/tags)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, prod, etc.)"
  type        = string
}

variable "bucket_name" {
  description = "Optional custom bucket name (must be globally unique). If null, module generates a name."
  type        = string
  default     = null
}

variable "aliases" {
  description = "CloudFront alternate domain names (e.g., root + app subdomain)"
  type        = list(string)
}

variable "acm_certificate_arn" {
  description = "ACM cert ARN (must be in us-east-1 for CloudFront)"
  type        = string
}

variable "enable_ipv6" {
  description = "Enable IPv6 for CloudFront distribution"
  type        = bool
  default     = true
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "spa_routing" {
  description = "If true, route 403/404 to /index.html (SPA routing)"
  type        = bool
  default     = true
}

variable "enable_domain_router_function" {
  description = "Optional CloudFront Function (viewer-request) for domain routing"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
