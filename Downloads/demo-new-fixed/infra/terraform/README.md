# VURSA Infrastructure (Terraform - Modular)

This repository contains Terraform code for VURSA infrastructure using a modular architecture (ACM, ALB, ECS, Route53, S3, Networking, RDS, etc.).  
The project is designed to support multiple environments (e.g., **dev** and **prod**) with the **same modules**, while keeping environment-specific configuration isolated.

 **Remote Terraform State is stored in S3**, so the state is not lost even if local files are deleted.  
 PR-based workflow is recommended for management review.

---

## Highlights

- **Modular Terraform structure** for clean reuse across environments
- **Environment folders** for `dev/` and `prod/` (same module usage, different inputs)
- **Remote backend (S3)** for Terraform state
- Safe Git practices: **state files and secrets are not committed**

---

## Repository Structure

High-level layout:
infra/
terraform/
dev/
*.tf
terraform.tfvars
backend.tf
prod/
*.tf
terraform.tfvars
backend.tf
modules/
acm/
alb/
docs/
ecr/
ecs/
elasticache/
frontend/
iam/
networking/
rds/
route53/
s3/


### What goes where?

- `infra/terraform/modules/`  
  Reusable modules (ACM, ECS, Networking, RDS, etc.)

- `infra/terraform/dev/` and `infra/terraform/prod/`  
  Environment-specific “root modules” that call shared modules and pass values via `terraform.tfvars`.

- `backend.tf` (per environment)  
  Configures remote state storage in S3 (and optional locking).

---

## Prerequisites

Install and configure:

- Terraform
- AWS CLI
- AWS credentials (Access Key / SSO / AWS Profile)

Verify setup:

```bash
terraform -version
aws --version
aws sts get-caller-identity


Environments

This repo supports:

dev → infra/terraform/dev

prod → infra/terraform/prod

Both environments use the same modules, but can differ in:

instance sizes

scaling values

domain names

VPC/subnet ranges

tags

bucket names

state key (path in S3)

Remote State (S3 Backend)

Terraform state is stored remotely in S3 so local deletion won’t break the infrastructure management.

Example (already in our env backend.tf):

terraform {
  backend "s3" {
    bucket = "vursa-terraform-state-prod"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
    # Optional locking:
    # use_lockfile  = true
    # dynamodb_table = "terraform-locks"
  }
}


=====================================================================
Notes:-

Never commit terraform.tfstate to GitHub.

For prod you should use a different state key like:

prod/terraform.tfstate

===================================================================

How to Run Terraform (Dev)

Location: infra/terraform/dev

cd infra/terraform/dev

terraform init
terraform plan
terraform apply


=====================================================================
How to Run Terraform (Prod)

Location: infra/terraform/prod

cd infra/terraform/prod

terraform init
terraform plan
terraform apply

====================================================================

Safety / Security

✅ Recommended:

Keep remote state in S3

Use encryption + versioning on the state bucket

Use locking (S3 lockfile or DynamoDB)

Use least-privilege IAM permissions


❌ Avoid:

Committing state files (terraform.tfstate)

Committing secrets in terraform.tfvars

Running terraform apply without checking terraform plan

Common Commands

Run these inside the environment folder (dev or prod):

terraform fmt -recursive
terraform validate
terraform plan
terraform apply
terraform output
terraform state list


====================================================================
Troubleshooting
1) “Resource already managed by Terraform” during import

That means the resource is already in state.
Use: terraform state list

If needed, remove the incorrect one (carefully): terraform state rm <address>



2) Backend migration to S3

If you switch from local to S3 backend: terraform init -migrate-state

Choose yes when asked to copy local state to S3.


