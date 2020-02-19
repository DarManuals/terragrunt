provider "aws" {
  profile = var.profile
  region  = var.region
}

terraform {
  backend "s3" {}
}

module "dev" {
  source   = "./dev"
  profile  = var.profile
  region   = var.region
  az_a     = var.az_a
  az_b     = var.az_b
  ec2_type = var.ec2_type
}

variable "profile" {}
variable "region" {}
variable "az_a" {}
variable "az_b" {}
variable "ec2_type" {}