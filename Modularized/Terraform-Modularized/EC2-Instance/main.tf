module "ec2-instance" {
  source = "../Modules/Terraform-EC2"

  is_instance_enabled             = var.is_instance_enabled
  instance_count                  = 1
  ec2_image                       = data.aws_ami.ami.id
  aws_instance_type               = var.aws_instance_type
  subnet_id                       = data.aws_subnet.public-subnet.id
  security_group                  = [data.aws_security_group.sg.id]
  instance_name                   = var.instance_name
  key_name                        = var.key_name
  ssm_parameter_store_file_name   = "/${var.instance_name}/${var.key_name}.pem"
  ssm_parameter_store_description = "Instance Pem file for ${var.instance_name} Instance"
  ssm_parameter_store_type        = "SecureString"
  ssm_parameter_store_file_path   = file("${path.module}/${var.key_name}.pem")
  # delete_file_command             = "rm -f ${path.module}/${var.key_name}.pem"
}