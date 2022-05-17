module myuserpool {
    source = "../../mymodules/cognito"

    domain                 = var.domain
    domain_certificate_arn = var.domain_certificate_arn

    user_pool_name         = var.user_pool_name
    tags                   = var.tags
    resource_servers       = var.resource_servers
    clients                = var.clients



}