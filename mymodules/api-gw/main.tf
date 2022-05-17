
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
resource "aws_api_gateway_resource" "example" {
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "example"
  rest_api_id = aws_api_gateway_rest_api.example.id
}

#Gateway Method
resource "aws_api_gateway_method" "example" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
}

#Gateway Integration

resource "aws_api_gateway_integration" "example" {
  http_method = aws_api_gateway_method.example.http_method
  resource_id = aws_api_gateway_resource.example.id
  rest_api_id = aws_api_gateway_rest_api.example.id
  type        = "MOCK"
}

#Gateway Deployment
resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.example.id,
      aws_api_gateway_method.example.id,
      aws_api_gateway_integration.example.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

#Gateway Stage
resource "aws_api_gateway_stage" "example" {
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  stage_name    = var.deployment_stage_name

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
  authorization_scopes =  [each.value.authorization_scopes,each.value.authorization_scopes_1]

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
  connection_id   = length(each.value.connection_id ) > 0 ? each.value.connection_id : null
}
/*
resource "aws_api_gateway_method_response" "response_200" {
  count       = each.value.type == "HTTP_PROXY" ? 0 : 1
  rest_api_id = aws_api_gateway_rest_api.example.id
  for_each    = var.method_variables
  resource_id = element(aws_api_gateway_resource.subpath[*][each.value.resource_path].id,0)
  http_method = each.value.integration_http_method
  status_code = "200"
}*/


resource "aws_api_gateway_vpc_link" "default" {
  name        = var.vpc_link_name
  description = "VPC Link for REST API"
  target_arns = var.nlb_arn
}