resource "aws_glue_crawler" "example" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  name          = "example"
  role          = aws_iam_role.iam-role.arn

  s3_target {
    path = "s3://s3-glue-bucket-544/source/"
  }
}