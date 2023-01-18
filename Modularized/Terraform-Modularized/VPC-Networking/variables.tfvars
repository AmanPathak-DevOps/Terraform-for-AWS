region               = "us-east-1"
is_enable_vpc        = 1
cidr_block_vpc       = "10.0.0.0/16"
instance_tenancy_vpc = "default"
dns                  = true
name_vpc             = "VPC-Networking"

is_enable_ig = 1
gateway_name = "IG-Networking"

is_subnet_enable_public = 1
public_cidr             = "10.0.1.0/24"
az1                     = "us-east-1a"
map_public_ip           = true
public_subnet           = "Public-Networking"

is_subnet_enable_private = 1
private_cidr             = "10.0.2.0/24"
az2                      = "us-east-1b"
map_private_ip           = false
private_subnet           = "Private-Networking"

is_enable_rt = 1
route_public = "0.0.0.0/0"
rt_name = "RT-Networking"

is_enable_rta = 1
