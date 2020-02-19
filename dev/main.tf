module "network" {
  source  = "./network"
  profile = var.profile
  region  = var.region
  az_a    = var.az_a
  az_b    = var.az_b
}

module "web" {
  source    = "./backend"
  profile   = var.profile
  region    = var.region
  ec2_type  = var.ec2_type
  subnet_id = module.network.private_subnet_id
  vpc_id    = module.network.vpc_id
}