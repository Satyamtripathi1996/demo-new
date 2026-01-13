terraform {
  backend "s3" {
    bucket         = "vursa-terraform-state-prod"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
