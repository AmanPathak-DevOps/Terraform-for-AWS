resource "aws_instance" "aws_instance" {
    count = "${var.is_instance_enabled == 1 && var.is_key_pair_enabled == 1 ? var.instance_count : 0}"

    ami = var.ec2_image
    instance_type = var.aws_instance_type
    subnet_id = var.subnet_id
    security_groups = var.security_group
    key_name = aws_key_pair.generated_key[count.index].key_name

    tags = {
        Name = var.instance_name
    }
}

resource "tls_private_key" "private_key" {
  count = "${var.is_private_key_enabled == 1 ? var.private_key_count : 0 }"

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  count = "${var.is_key_pair_enabled == 1 ? var.key_pair_count : 0 }"

  key_name   = var.key_name
  public_key = tls_private_key.private_key[count.index].public_key_openssh
  
  provisioner "local-exec" { 
   command = "echo '${tls_private_key.private_key[count.index].private_key_pem}' > ./${var.key_name}.pem"
  }

}

resource "aws_ssm_parameter" "pem-file" {
  count = "${var.is_paramter_store_enabled == 1 ? var.paramter_store_count : 0 }"

  name = var.ssm_parameter_store_file_name
  description = var.ssm_parameter_store_description
  type = var.ssm_parameter_store_type
  value = var.ssm_parameter_store_file_path
}

resource "null_resource" "delete_pem_file" {
  provisioner "local-exec" {
    command     = "rm -f ${path.module}/${var.key_name}.pem"
    when        = destroy
  }

  depends_on = [aws_ssm_parameter.pem-file]
}

resource "aws_s3_bucket" "bucket_for_pem_files" {
    count = "${var.is_bucket_enable == 1 ? var.bucket_count : 0 }"

    bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "block_access" {
    count = "${var.is_bucket_enable == 1 ? var.bucket_count : 0}"

    bucket = aws_s3_bucket.bucket_for_pem_files[count.index].id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_object" "pem-file-upload" {
    count = "${var.is_bucket_enable == 1 ? var.bucket_count : 0}"

    bucket = aws_s3_bucket.bucket_for_pem_files[count.index].id
    key = "${var.key_name}.pem"
    source = "./${var.key_name}.pem"
}