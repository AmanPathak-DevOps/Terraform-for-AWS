region = "us-east-1"
is_lambda_enabled   = 0
functionname       = "lambda"
lambdafunctionname = "-for-SNS"
lambda-runtime     = "python3.8"
lambda-handler     = "code.lambda_handler"
handler-code       = "code.zip"
role-lambda        = aws_iam_role.iam-role.arn
timout-lambda      = "120"
memory-size        = "128"
sdlc_env            = "dev"

