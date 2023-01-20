module "vpc" {
  source = "../Modules/Terraform-VPC"

  is_vpc_enable = var.is_enable_vpc
  vpc_count     = 1
  cidr_block    = var.cidr_block_vpc
  tenancy       = var.instance_tenancy_vpc
  dns_hostname  = var.dns
  vpc_name      = var.name_vpc

  is_gateway_enable     = var.is_enable_ig
  gateway_count         = 1
  internet_gateway_name = var.gateway_name

  is_public_subnet_enable = var.is_subnet_enable_public
  public_subnet_count     = 1
  subnet_cidr1            = var.public_cidr
  zone1                   = var.az1
  public_ip               = var.map_public_ip
  subnet_name1            = var.public_subnet

  is_private_subnet_enable = var.is_subnet_enable_private
  private_subnet_count     = 1
  subnet_cidr2             = var.private_cidr
  zone2                    = var.az2
  private_ip               = var.map_private_ip
  subnet_name2             = var.private_subnet

  is_rt_enable     = var.is_enable_rt
  rt_count         = 1
  public_route     = var.route_public
  route_table_name = var.rt_name

  is_rta_enable = var.is_enable_rta
  rta_count     = 1

  is_aws_security_group_enable = var.is_sg_enable
  security_group_count         = 1
  from_port1                   = var.from_port1
  to_port1                     = var.to_port1
  from_port2                   = var.from_port2
  to_port2                     = var.to_port2
  security_group_name          = var.sg_name
}