terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  # Optional remote backend (example)
  # backend "s3" {
  #   bucket = "YOUR_TFSTATE_BUCKET"
  #   key    = "vursa/dev/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = var.aws_region
}

# CloudFront requires ACM cert in us-east-1
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
