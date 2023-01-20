variable "region" {}
variable "is_enable_vpc" {}
variable "cidr_block_vpc" {}
variable "instance_tenancy_vpc" {}
variable "dns" {}
variable "name_vpc" {}

variable "is_enable_ig" {}
variable "gateway_name" {}

variable "is_subnet_enable_public" {}
variable "public_cidr" {}
variable "az1" {}
variable "map_public_ip" {}
variable "public_subnet" {}

variable "is_subnet_enable_private" {}
variable "private_cidr" {}
variable "az2" {}
variable "map_private_ip" {}
variable "private_subnet" {}

variable "is_enable_rt" {}
variable "route_public" {}
variable "rt_name" {}

variable "is_enable_rta" {}

variable "is_sg_enable" {}
variable "from_port1" {}
variable "to_port1" {}
variable "from_port2" {}
variable "to_port2" {}
variable "sg_name" {}