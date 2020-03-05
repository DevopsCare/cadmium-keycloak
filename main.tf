/*
 * Copyright (C) 2019 DevOps, SIA. - All Rights Reserved
 * You may use, distribute and modify this code under the
 * terms of the Apache License Version 2.0.
 * http://www.apache.org/licenses
 */

locals {
  vpc_id             = var.vpc_id == "" ? module.vpc.vpc_id : var.vpc_id
  private_subnet_ids = coalescelist(module.vpc.private_subnets, var.private_subnet_ids, [""])
  public_subnet_ids  = coalescelist(module.vpc.public_subnets, var.public_subnet_ids, [""])
}

module "label" {
  source      = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace   = var.namespace
  name        = var.name
  stage       = var.stage
  environment = var.environment
  delimiter   = var.delimiter
  attributes  = var.attributes
  tags        = var.tags
}

#######
# VPC #
#######
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v2.5.0"

  create_vpc = var.vpc_id == ""

  name = module.label.id

  cidr            = var.cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = module.label.tags
}

# ###################
# # RDS
# ###################

# module "rds_instance" {
#   source                      = "git::https://github.com/cloudposse/terraform-aws-rds.git?ref=0.18.0"
#   namespace                   = module.label.namespace
#   stage                       = module.label.stage
#   name                        = module.label.name
#   environment                 = module.label.environment
#   delimiter                   = module.label.delimiter
#   attributes                  = module.label.attributes
#   tags                        = module.label.tags

#   allocated_storage           = 10
#   allow_major_version_upgrade = false
#   # allowed_cidr_blocks         = ["XXX.XXX.XXX.XXX/32"]
#   apply_immediately           = true
#   auto_minor_version_upgrade  = true
#   backup_retention_period     = 7
#   backup_window               = "22:00-03:00"
#   ca_cert_identifier          = "rds-ca-2019"
#   copy_tags_to_snapshot       = true
#   database_name               = "keycloak"
#   database_user               = "keycloak"

#   # TODO
#   database_password           = "xxxxxxxxxxxx"
#   database_port               = 5432
  
#   db_options = [
#     { option_name = "SQLSERVER_BACKUP_RESTORE"
#         option_settings = [
#           { name = "IAM_ROLE_ARN"           value = var.iam_role_mssql_backup },
#         ]
#     }
#   ]

#   dns_zone_id                 = "Z89FN1IW975KPE"
#   engine                      = "postgresql"
#   engine_version              = "11.6"
#   final_snapshot_identifier   = "${module.label.id}"
#   host_name                   = "${module.label.id}"
#   instance_class              = "db.t3.micro"
#   maintenance_window          = "Mon:03:00-Mon:04:00"
#   security_group_ids          = ["sg-xxxxxxxx"]
#   skip_final_snapshot         = true
#   storage_encrypted           = true
  
  
  
  
  
  
  
  
  # subnet_ids                  = ["sb-xxxxxxxxx", "sb-xxxxxxxxx"]
  # vpc_id                      = "vpc-xxxxxxxx"
  

  

