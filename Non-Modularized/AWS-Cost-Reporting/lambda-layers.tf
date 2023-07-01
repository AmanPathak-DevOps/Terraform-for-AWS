resource "aws_lambda_layer_version" "Datetime-layer" {
  filename                 = "${path.module}/DateTime.zip"
  layer_name               = "DateTime-Package"
  compatible_runtimes      = ["python3.9", "python3.10"]
  compatible_architectures = ["x86_64"]
}