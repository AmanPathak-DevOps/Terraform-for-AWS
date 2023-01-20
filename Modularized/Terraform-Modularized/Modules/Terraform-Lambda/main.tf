resource "aws_lambda_function" "lamda-1" {
    count                          = "${var.is_enabled == 1 ? var.lambdafile_count : 0}"
    function_name                  = "${var.function}_${var.lambda_function_name}"
    handler                        = "${var.handler-for-lambda}"
    runtime                        = "${var.runtime-for-lambda}"
    filename                       = "${var.code-for-lambda}"
    source_code_hash               = filebase64sha256(var.code-for-lambda)
    role                           = "${var.role-for-lambda}"
    timeout                        = "${var.timeout-for-lambda}"
    memory_size                    = "${var.memory-size-for-lambda}"

    environment {
        variables = var.lambda_env
    }
}