locals {
  subnets = [for cidr_block in cidrsubnets(var.vpc_cidr, 2, 2) : cidrsubnets(cidr_block, 2, 2)]

  gateway-subnet = local.subnets[0][0]
  mgmt-subnet    = local.subnets[0][1]
  rds-subnet     = local.subnets[1][0]
}