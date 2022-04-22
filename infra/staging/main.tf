terraform {
  required_version = "~> 1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.8.0"
    }
  }
}

locals {
  default_prefix = "${var.tags.Project}-${var.tags.Environment}"
}

module "network" {
  source = "../modules/network/"

  prefix             = local.default_prefix
  vpc_cidr           = var.vpc_cidr
  private_subnets    = var.private_subnets
  interface_services = var.vpc_endpoint.interface
  gateway_services   = var.vpc_endpoint.gateway

  tags = var.tags
}

module "bastion" {
  source = "../modules/bastion/"

  prefix            = local.default_prefix
  vpc_id            = module.network.vpc_id
  private_subnet_id = module.network.private_subnet_ids[0]
  key_pair_name     = var.key_pair_name

  tags = var.tags
}
