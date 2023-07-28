# Global

variable "region" {}

#EC2-Instance

variable "is_instance_enabled" {}
variable "aws_instance_type" {}
variable "instance_name" {}
variable "key_name" {}

# variable "public_subnet" {}
variable "security_group" {}

#IAM-Roles

variable "role_name" {}
variable "role_policy_file" {}

variable "policy_name" {}
variable "policy_file" {}

# Lambda-Function

variable "is_lambda_enabled" {}
variable "functionname" {}
variable "lambdafunctionname" {}
variable "lambda-runtime" {}
variable "lambda-handler" {}
variable "handler-code" {}
variable "timout-lambda" {}
variable "memory-size" {}
variable "sdlc_env" {}

# S3-Bucket

variable "is_bucket_enabled" {}
variable "bucket_name" {}
variable "force_destroy" {}
variable "env" {}

# SNS-Bucket

variable "is_enable" {}
variable "topic_name" {}


variable "is_subscription_enable" {}
variable "protocol_subscription" {}
variable "endpoint" {}

# VPC-Networking

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