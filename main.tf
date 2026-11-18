terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  skip_region_validation      = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
}

locals {
  es_prod        = var.ambiente == "prod"
  nombre_prefijo = "${var.proyecto}-${var.ambiente}"

  common_tags = {
    Proyecto    = var.proyecto
    Aplicacion  = var.aplicacion
    Ambiente    = var.ambiente
    Responsable = var.responsable
  }
}

module "vpc" {
  source = "./vpc"

  vpc_cidr       = var.vpc_cidr
  subredes       = var.subredes
  nombre_prefijo = local.nombre_prefijo
  common_tags    = local.common_tags
}

module "ec2" {
  source = "./ec2"

  servidores     = var.servidores
  subredes_ids   = module.vpc.subredes_ids
  sg_ec2_id      = module.vpc.sg_ec2_id
  key_name       = var.key_name
  es_prod        = local.es_prod
  ambiente       = var.ambiente
  nombre_prefijo = local.nombre_prefijo
  common_tags    = local.common_tags
}

module "nlb" {
  source = "./nlb"

  vpc_id                = module.vpc.vpc_id
  subredes_publicas_ids = module.vpc.subredes_publicas_ids
  instancias_ids        = module.ec2.instancias_ids
  nombre_prefijo        = local.nombre_prefijo
  common_tags           = local.common_tags
}

module "rds" {
  source = "./rds"

  subredes_privadas_ids = module.vpc.subredes_privadas_ids
  sg_rds_id             = module.vpc.sg_rds_id
  db_name               = var.db_name
  db_username           = var.db_username
  db_password           = var.db_password
  es_prod               = local.es_prod
  nombre_prefijo        = local.nombre_prefijo
  common_tags           = local.common_tags
}

module "s3" {
  source = "./s3"

  proyecto    = var.proyecto
  aplicacion  = var.aplicacion
  ambiente    = var.ambiente
  es_prod     = local.es_prod
  common_tags = local.common_tags
}