resource "aws_api_gateway_rest_api" "lambda_api" {
  name        = var.rest_api_name
  description = var.rest_api_description

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


resource "aws_api_gateway_resource" "add_student_resource" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id   = aws_api_gateway_rest_api.lambda_api.root_resource_id
  path_part   = var.api_resource_one

  depends_on = [aws_api_gateway_rest_api.lambda_api]
}

resource "aws_api_gateway_method" "add_student_method" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  resource_id   = aws_api_gateway_resource.add_student_resource.id
  http_method   = "POST"
  authorization = "NONE"

  depends_on = [aws_api_gateway_resource.add_student_resource]
}

resource "aws_api_gateway_method_response" "add_student_response_200" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.add_student_resource.id
  http_method = aws_api_gateway_method.add_student_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true,
  }

  response_models = {
    "application/json" = "Empty"
  }

  depends_on = [aws_api_gateway_method.add_student_method]
}

resource "aws_api_gateway_integration" "add_student_integration" {
  rest_api_id             = aws_api_gateway_rest_api.lambda_api.id
  resource_id             = aws_api_gateway_resource.add_student_resource.id
  http_method             = aws_api_gateway_method.add_student_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.POST_lambda.invoke_arn

  depends_on = [aws_api_gateway_method.add_student_method]
}

resource "aws_api_gateway_integration_response" "add_student_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.add_student_resource.id
  http_method = aws_api_gateway_method.add_student_method.http_method
  status_code = aws_api_gateway_method_response.add_student_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = <<EOF
EOF
  }

  depends_on = [aws_api_gateway_integration.add_student_integration]
}



# GET resource and method
resource "aws_api_gateway_resource" "get_student_resource" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  parent_id   = aws_api_gateway_rest_api.lambda_api.root_resource_id
  path_part   = var.api_resource_two

  depends_on = [aws_api_gateway_rest_api.lambda_api]
}

resource "aws_api_gateway_method" "get_student_method" {
  rest_api_id   = aws_api_gateway_rest_api.lambda_api.id
  resource_id   = aws_api_gateway_resource.get_student_resource.id
  http_method   = "GET"
  authorization = "NONE"

  depends_on = [aws_api_gateway_resource.get_student_resource]
}

resource "aws_api_gateway_method_response" "get_student_response_200" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.get_student_resource.id
  http_method = aws_api_gateway_method.get_student_method.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
  response_models = {
    "application/json" = "Empty"
  }

  depends_on = [aws_api_gateway_method.get_student_method]
}





resource "aws_api_gateway_integration" "get_student_integration" {
  rest_api_id             = aws_api_gateway_rest_api.lambda_api.id
  resource_id             = aws_api_gateway_resource.get_student_resource.id
  http_method             = aws_api_gateway_method.get_student_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.GET_lambda.invoke_arn

  depends_on = [aws_api_gateway_method.get_student_method]
}

resource "aws_api_gateway_integration_response" "get_student_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  resource_id = aws_api_gateway_resource.get_student_resource.id
  http_method = aws_api_gateway_method.get_student_method.http_method
  status_code = aws_api_gateway_method_response.get_student_response_200.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [aws_api_gateway_integration.get_student_integration]
}


# Deploy the API
resource "aws_api_gateway_deployment" "student_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.lambda_api.id
  stage_name  = "Prod"

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.add_student_resource.id,
      aws_api_gateway_method.add_student_method.id,
      aws_api_gateway_integration.add_student_integration.id,
      aws_api_gateway_method_response.add_student_response_200.id,
      aws_api_gateway_integration_response.add_student_integration_response.id,
      aws_api_gateway_resource.get_student_resource.id,
      aws_api_gateway_method.get_student_method.id,
      aws_api_gateway_integration.get_student_integration.id,
      aws_api_gateway_method_response.get_student_response_200.id,
      aws_api_gateway_integration_response.get_student_integration_response.id,
      aws_api_gateway_method.options_method.id,
      aws_api_gateway_integration.options_integration.id,
      aws_api_gateway_method_response.options_response_200.id,
      aws_api_gateway_integration_response.options_integration_response.id
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}


