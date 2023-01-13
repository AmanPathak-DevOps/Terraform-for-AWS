module "lambda-for-SNS" {
  source = "../Modules/Terraform-Lambda"
  
  is_enabled             = 1 // To disable the lambda override with 0
  lambdafile_count       = 1
  function               = var.functionname
  lambda_function_name   = var.lambdafunctionname
  runtime-for-lambda     = var.lambda-runtime
  handler-for-lambda     = var.lambda-handler
  code-for-lambda        = var.handler-code
  role-for-lambda        = aws_iam_role.iam-role.arn // var.role-lambda variable approach not working because it needs the direct arn so the alternative of this "data" 
  timeout-for-lambda     = var.timout-lambda
  memory-size-for-lambda = var.memory-size

  lambda_env = {
    ENV = var.sdlc_env
  }
}


