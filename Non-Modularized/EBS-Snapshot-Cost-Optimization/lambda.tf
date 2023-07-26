resource "aws_lambda_function" "cost-reporting-lambda" {
  filename         = "python-code.zip"
  function_name    = var.lambda-function-name
  role             = aws_iam_role.role-for-cost-optimization.arn
  handler          = "ebs_snapshot_cost_optimization.lambda_handler"
  timeout          = 10
  memory_size      = 128
  runtime          = "python3.10"
  source_code_hash = filebase64sha256("ebs_snapshot_cost_optimization.zip")
}