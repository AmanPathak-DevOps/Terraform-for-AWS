variable "is_vpc_enable" {}
variable "vpc_count" {}
variable "cidr_block" {}
variable "tenancy" {}
variable "dns_hostname" {}
variable "vpc_name" {}

variable "is_gateway_enable" {}
variable "gateway_count" {}
variable "internet_gateway_name" {}

variable "is_public_subnet_enable" {}
variable "public_subnet_count" {}
variable "subnet_cidr1" {}
variable "zone1" {}
variable "public_ip" {}
variable "subnet_name1" {}

variable "is_private_subnet_enable" {}
variable "private_subnet_count" {}
variable "subnet_cidr2" {}
variable "zone2" {}
variable "subnet_name2" {}
variable "private_ip" {}

variable "is_rt_enable" {}
variable "rt_count" {}
variable "public_route" {}
variable "route_table_name" {}

variable "is_rta_enable" {}
variable "rta_count" {}

variable "is_aws_security_group_enable" {}
variable "security_group_count" {}
variable "from_port1" {}
variable "to_port1" {}
variable "from_port2" {}
variable "to_port2" {}
variable "security_group_name" {}
