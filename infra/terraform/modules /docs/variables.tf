variable "app_name" { type = string }
variable "environment" { type = string }

variable "domain_name" {
  description = "Root domain (example.com). Docs will be docs.<domain>"
  type        = string
}

variable "bucket_name" {
  description = "Optional custom docs bucket name"
  type        = string
  default     = null
}

variable "acm_certificate_arn" {
  description = "ACM cert ARN (must be us-east-1 for CloudFront)"
  type        = string
}

variable "enable_ipv6" { type = bool default = true }
variable "price_class" { type = string default = "PriceClass_100" }
variable "spa_routing" { type = bool default = true }

variable "tags" { type = map(string) default = {} }
