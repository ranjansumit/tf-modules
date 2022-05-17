# Region
variable "region_name" {
    default = "us-east-1"
  
}

#REST API
variable "vpc_endpoint_ids" {
    type    = list(string)
    default =  ["vpce-0f09ddfa9109f58ea"]
}

variable "rest_api_name" {
    type    =  string
    default = "example1"
}

variable "rest_api_type" {
    type    =  list(string)
    default = ["PRIVATE"]
}

variable "rest_api_policy" {
  type = string
  default     = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "execute-api:Invoke",
            "Resource": "arn:aws:execute-api:us-east-1:516852271566:*/*"
            }
           ]
}
POLICY
  description = "The policy document."
}

variable "rest_api_tags" {
    type = map(any)
    default = {
                "Key": "CreatedBy",
                "Value": "BpsAppsCF"
            }
  
}

#Authorizer
variable "auth_provider_arns" {
    type    = list(any)
    default = [ "arn:aws:cognito-idp:us-east-1:516852271566:userpool/us-east-1_i8F7fq9ks" ]
}

variable "auth_name" {
    type    =  string
    default = "demo"
}

variable "auth_type" {
    type    =  string
    default = "COGNITO_USER_POOLS"
}

variable "auth_identity_source" {
    type    =  string
    default = "method.request.header.authorization"
}


#Gateway Resource

variable "resource_path_part" {
    type    =  list(string)
    default = ["pplus","search","wma"]
}

variable "sub_resource_path_part" {
    type    =  map(map(string))
    default = {
        "pplus{proxy+}" = {
                name   = "{proxy+}"
                parent = "pplus"
                },
        "pplusproducer" = {
                name   = "producer"
                parent = "pplus"
                },
        "search{proxy+}" = {
                name   = "{proxy+}"
                parent = "search"
        },
        "wma{proxy+}" = {
                name   = "{proxy+}"
                parent = "wma"
        }
        } 
        
}

variable "method_variables" {
    type = map(map(any))
    default = {
        method1={http_method="GET",resource="{proxy+}",resource_path="pplus{proxy+}",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://pplus-service/RestReadAccess",authorization_scopes_1="",cache_key_parameters="method.request.path.proxy",connection_id="0vy0r7",connection_type="VPC_LINK",integration_http_method="GET",passthrough_behavior="WHEN_NO_MATCH",type="HTTP_PROXY",uri="https://www.google.de/{proxy+}",request_parameters_key="integration.request.path.proxy" ,request_parameters_value="'method.request.path.proxy'"},
        method2={http_method="POST",resource="{proxy+}",resource_path="pplus{proxy+}",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://pplus-service/RestCreateUpdateDeleteAccess",authorization_scopes_1="",cache_key_parameters="method.request.path.proxy",connection_id="0vy0r7",connection_type="VPC_LINK",integration_http_method="POST",passthrough_behavior="WHEN_NO_MATCH",type="HTTP_PROXY",uri="https://www.google.de/{proxy+}",request_parameters_key="integration.request.path.proxy" ,request_parameters_value="'method.request.path.proxy'"},
        method3={http_method="PUT",resource="{proxy+}",resource_path="pplus{proxy+}",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://pplus-service/RestCreateUpdateDeleteAccess",authorization_scopes_1="",cache_key_parameters="method.request.path.proxy",connection_id="0vy0r7",connection_type="VPC_LINK",integration_http_method="PUT",passthrough_behavior="WHEN_NO_MATCH",type="HTTP_PROXY",uri="https://www.google.de/{proxy+}",request_parameters_key="integration.request.path.proxy" ,request_parameters_value="'method.request.path.proxy'"},
        method4={http_method="DELETE",resource="{proxy+}",resource_path="pplus{proxy+}",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://pplus-service/RestCreateUpdateDeleteAccess",authorization_scopes_1="",cache_key_parameters="method.request.path.proxy",connection_id="0vy0r7",connection_type="VPC_LINK",integration_http_method="DELETE",passthrough_behavior="WHEN_NO_MATCH",type="HTTP_PROXY",uri="https://www.google.de/{proxy+}",request_parameters_key="integration.request.path.proxy" ,request_parameters_value="'method.request.path.proxy'"},
        method5={http_method="GET",resource="producer",resource_path="pplusproducer",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://pplus-service/RestReadAccess",authorization_scopes_1="",cache_key_parameters="method.request.path.proxy",connection_id="0vy0r7",connection_type="VPC_LINK",integration_http_method="GET",passthrough_behavior="WHEN_NO_MATCH",type="HTTP_PROXY",uri="https://www.google.de/producer",request_parameters_key="integration.request.path.proxy" ,request_parameters_value="'method.request.path.proxy'"},
        method6={http_method="POST",resource="producer",resource_path="pplusproducer",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://pplus-service/RestCreateProducerAccess",authorization_scopes_1="",cache_key_parameters="",connection_id="",connection_type="",integration_http_method="POST",passthrough_behavior="",type="AWS_PROXY",uri="LAMBDA_ARN",request_parameters_key="" ,request_parameters_value=""},
        method7={http_method="POST",resource="{proxy+}",resource_path="search{proxy+}",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://search-services/Policy",authorization_scopes_1="https://search-services/Client",cache_key_parameters="method.request.path.proxy",connection_id="0vy0r7",connection_type="VPC_LINK",integration_http_method="POST",passthrough_behavior="WHEN_NO_MATCH",type="HTTP_PROXY",uri="https://www.google.de/{proxy+}",request_parameters_key="integration.request.path.proxy" ,request_parameters_value="'method.request.path.proxy'"},
        method8={http_method="GET",resource="{proxy+}",resource_path="wma{proxy+}",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://wma-services/RestReadAccess",authorization_scopes_1="",cache_key_parameters="method.request.path.proxy",connection_id="0vy0r7",connection_type="VPC_LINK",integration_http_method="GET",passthrough_behavior="WHEN_NO_MATCH",type="HTTP_PROXY",uri="https://www.google.de/{proxy+}",request_parameters_key="integration.request.path.proxy" ,request_parameters_value="'method.request.path.proxy'"},
        method9={http_method="POST",resource="{proxy+}",resource_path="wma{proxy+}",authorization="COGNITO_USER_POOLS",api_key_required=false,authorization_scopes="https://wma-services/RestReadAccess",authorization_scopes_1="",cache_key_parameters="method.request.path.proxy",connection_id="0vy0r7",connection_type="VPC_LINK",integration_http_method="POST",passthrough_behavior="WHEN_NO_MATCH",type="HTTP_PROXY",uri="https://www.google.de/{proxy+}",request_parameters_key="integration.request.path.proxy" ,request_parameters_value="'method.request.path.proxy'"},
        }
}


# Deployment Stage: Name

variable "deployment_stage_name" {
    type= string
    default="mydeployment1"
  
}

variable "deployment_variables"{
    type= map(string)
    default={"QueueUrlVariable"="PplusLambdaSsmQueueUrlParamName"}
}

variable "method_resource_path" {
    type= string
    default="/*"
  
}

variable "method_http_method" {
    type= string
    default="*"
  
}

#VPC Link + Load Balancer

variable "vpc_link_name"{
    default = "myvpc"
    type    = string
}

variable "nlb_arn"{
    default = []
    type    = list(string)
}

variable "target_group_arn" {
    type = string
    default = ""
  
}