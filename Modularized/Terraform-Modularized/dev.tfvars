region = "us-east-1"

# EC2-Instance
is_instance_enabled = 1
aws_instance_type   = "t2.micro"
instance_name       = "Ubuntu-Networking"
security_group      = "SecurityGroup-Networking"
key_name            = "instance-key"

# IAM-Roles
role_name        = "iam-role-lambda"
role_policy_file = "role.json"

policy_name = "AWS-Lambda-Role"
policy_file = "policy.json"

# Lambda-Function
is_lambda_enabled  = 0
functionname       = "lambda"
lambdafunctionname = "-for-SNS"
lambda-runtime     = "python3.8"
lambda-handler     = "code.lambda_handler"
handler-code       = "code.zip"
role-lambda        = aws_iam_role.iam-role.arn
timout-lambda      = "120"
memory-size        = "128"
sdlc_env           = "dev"


# S3-Bucket
is_bucket_enabled = 1
bucket_name       = "the-far-est-baket"
force_destroy     = true
env               = "Development"


# VPC-Networking
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
rt_name      = "RT-Networking"

is_enable_rta = 1

is_sg_enable = 1
from_port1   = 22
to_port1     = 22
from_port2   = 80
to_port2     = 80
sg_name      = "SecurityGroup-Networking"


# SNS-Topic
is_enable  = 1
topic_name = "SNS-Modularized"

is_subscription_enable = 1
protocol_subscription  = "email"
endpoint               = "avigautam63@gmail.com"