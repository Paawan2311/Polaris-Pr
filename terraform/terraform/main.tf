module "vpc" {
  source          = "./modules/vpc"
  name            = var.name
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  azs             = var.azs
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  cluster_version    = var.cluster_version
  private_subnet_ids = module.vpc.private_subnets
}
