
#REST_API completed
resource "aws_api_gateway_rest_api" "example" {
  name = var.rest_api_name
  policy= var.rest_api_policy
  endpoint_configuration {
      types            = var.rest_api_type
      vpc_endpoint_ids = var.vpc_endpoint_ids
  }
  tags = var.rest_api_tags
}

#Resource
#resource "aws_api_gateway_resource" "example" {
#  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
#  path_part   = "example"
#  rest_api_id = aws_api_gateway_rest_api.example.id
#}

/*
#Gateway Method
resource "aws_api_gateway_method" "example" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
}
*/

#Gateway Integration
/*
resource "aws_api_gateway_integration" "example" {
  http_method = aws_api_gateway_method.example.http_method
  resource_id = aws_api_gateway_resource.example.id
  rest_api_id = aws_api_gateway_rest_api.example.id
  type        = "MOCK"
}*/

#Gateway Deployment

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id

  lifecycle {
    create_before_destroy = true
  }
  depends_on        = [aws_api_gateway_method.method, aws_api_gateway_integration.integration]
}

#Gateway Stage

resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = var.deployment_stage_name
  variables     = var.deployment_variables
}



resource "aws_api_gateway_method_settings" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = aws_api_gateway_stage.example.stage_name
  method_path = join("/", [var.method_resource_path, var.method_http_method])

  settings {
    metrics_enabled = true
    logging_level   = "INFO"
    data_trace_enabled = true
    
  }
}


#Gateway Authorizer completed

resource "aws_api_gateway_authorizer" "demo" {
  name                   = var.auth_name
  rest_api_id            = aws_api_gateway_rest_api.example.id
  #authorizer_uri         = aws_lambda_function.authorizer.invoke_arn
  type                   = var.auth_type
  provider_arns          = var.auth_provider_arns
  identity_source        = var.auth_identity_source

}


#Gateway Resource completed

resource "aws_api_gateway_resource" "default" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  #path_part   = for_each.resource_path_part

  for_each   = toset(var.resource_path_part)
  path_part = each.key
}
#Gateway Sub Resource completed
resource "aws_api_gateway_resource" "subpath" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  for_each    = var.sub_resource_path_part
  path_part   = each.value.name
  parent_id   = aws_api_gateway_resource.default[each.value.parent].id
}

#Gateway Method 

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  
  for_each      = var.method_variables
  resource_id   = element(aws_api_gateway_resource.subpath[*][each.value.resource_path].id,0)
  http_method   = each.value.http_method
  authorization = each.value.authorization
  authorizer_id = aws_api_gateway_authorizer.demo.id
  api_key_required = each.value.api_key_required
  authorization_scopes = /*each.value.authorization_scopes_1 == "" ? [each.value.authorization_scopes,each.value.authorization_scopes_1]:*/each.value.authorization_scopes

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id          = aws_api_gateway_rest_api.example.id
  for_each             = var.method_variables
  resource_id          = element(aws_api_gateway_resource.subpath[*][each.value.resource_path].id,0)
  http_method          = each.value.http_method
  
  request_parameters   = each.value.type == "HTTP_PROXY" ? { "integration.request.path.proxy": "method.request.path.proxy" } : null
  cache_key_parameters = length([each.value.cache_key_parameters]) > 0 ? [each.value.cache_key_parameters] : null
  type                    = each.value.type
  uri                     = each.value.uri
  integration_http_method = length(each.value.integration_http_method) > 0 ? each.value.integration_http_method : null
  passthrough_behavior    = length(each.value.passthrough_behavior) > 0 ? each.value.passthrough_behavior : null

  connection_type = length(each.value.connection_type) > 0 ? each.value.connection_type : null
  connection_id   = each.value.type == "HTTP_PROXY" ? aws_api_gateway_vpc_link.default.id : null
  depends_on              = [aws_api_gateway_method.method]
}

resource "aws_api_gateway_method_response" "response_200" {
  #count       = each.value.type == "HTTP_PROXY" ? 0 : 1
  rest_api_id = aws_api_gateway_rest_api.example.id
  #for_each    = var.method_variables
  for_each = {
    for name, method in var.method_variables : name => method
    if method.type !="AWS_PROXY"
  }
  resource_id = element(aws_api_gateway_resource.subpath[*][each.value.resource_path].id,0)
  http_method = each.value.integration_http_method
  status_code = "200"
  depends_on  = [aws_api_gateway_method.method]
}

resource "aws_api_gateway_integration_response" "integration_response" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  #for_each    = var.method_variables
  for_each = {
    for name, method in var.method_variables : name => method
    if method.type !="AWS_PROXY"
  }
  resource_id = element(aws_api_gateway_resource.subpath[*][each.value.resource_path].id,0)
  http_method = each.value.integration_http_method
  status_code = aws_api_gateway_method_response.response_200[each.key].status_code
  depends_on  = [aws_api_gateway_method_response.response_200]
}

resource "aws_api_gateway_vpc_link" "default" {
  name        = var.vpc_link_name
  description = "VPC Link for REST API"
  target_arns = var.nlb_arn
}