data "archive_file" "zip-python-code" {
  type        = "zip"
  source_dir  = "${path.module}/code/"
  output_path = "${path.module}/code/hello.zip"
}