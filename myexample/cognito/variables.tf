#
# aws_cognito_user_pool
#
variable "enabled" {
  description = "Change to false to avoid deploying any resources"
  type        = bool
  default     = true
}

variable "user_pool_name" {
  description = "The name of the user pool"
  type        = string
}

variable "email_verification_message" {
  description = "A string representing the email verification message"
  type        = string
  default     = null
}

variable "email_verification_subject" {
  description = "A string representing the email verification subject"
  type        = string
  default     = null
}

# username_configuration
variable "username_configuration" {
  description = "The Username Configuration. Seting `case_sesiteve` specifies whether username case sensitivity will be applied for all users in the user pool through Cognito APIs"
  type        = map(any)
  default     = {}
}

# tags
variable "tags" {
  description = "A mapping of tags to assign to the User Pool"
  type        = map(string)
  default     = {"CreatedBy": "BpsAppsCF"}
}

# user_pool_add_ons
variable "user_pool_add_ons" {
  description = "Configuration block for user pool add-ons to enable user pool advanced security mode features"
  type        = map(any)
  default     = {}
}

variable "user_pool_add_ons_advanced_security_mode" {
  description = "The mode for advanced security, must be one of `OFF`, `AUDIT` or `ENFORCED`"
  type        = string
  default     = null
}

# verification_message_template
variable "verification_message_template" {
  description = "The verification message templates configuration"
  type        = map(any)
  default     = {}
}

variable "verification_message_template_default_email_option" {
  description = "The default email option. Must be either `CONFIRM_WITH_CODE` or `CONFIRM_WITH_LINK`. Defaults to `CONFIRM_WITH_CODE`"
  type        = string
  default     = null
}

variable "verification_message_template_email_message_by_link" {
  description = "The email message template for sending a confirmation link to the user, it must contain the `{##Click Here##}` placeholder"
  type        = string
  default     = null
}

variable "verification_message_template_email_subject_by_link" {
  description = "The subject line for the email message template for sending a confirmation link to the user"
  type        = string
  default     = null
}

#
# aws_cognito_user_pool_domain
#
variable "domain" {
  description = "Cognito User Pool domain"
  type        = string
  default     = null
}

variable "domain_certificate_arn" {
  description = "The ARN of an ISSUED ACM certificate in us-east-1 for a custom domain"
  type        = string
  default     = null
}

#
# aws_cognito_user_pool_client
#
variable "clients" {
  description = "A container with the clients definitions"
  type        = any
  default     = [
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://eclipse-service/DocumentIndexing"]
      callback_urls                        = ["https://mydomain.com/callback"]
      default_redirect_uri                 = "https://mydomain.com/callback"
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.document-index-services"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://ace-services/FullAccess",
                    "https://eclipse-service/PolicySearch",
                    "https://eclipse-service/RetrieveImageWithDocKey",
                    "https://pplus-service/RestReadAccess",
                    "https://wma-services/RestReadAccess"]
      callback_urls                        = ["https://mydomain.com/callback"]
      default_redirect_uri                 = "https://mydomain.com/callback"
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.ace-ui"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://eclipse-service/RetrieveImageWithDocKey"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.ace-services"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://ace-api/FullAccess",
                    "https://eclipse-service/PolicySearch",
                    "https://eclipse-service/RetrieveImageWithDocKey"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.csr-portal"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://search-services/Policy",
                    "https://search-services/Client",
                    "https://eclipse-service/RetrieveImageWithDocKey",
                    "https://secure-document-service/DocumentAccess",
                    "https://pplus-service/RestReadAccess",
                    "https://pplus-service/RestCreateUpdateDeleteAccess",
                    "https://wma-services/RestReadAccess",
                    "https://wma-services/RestCreateUpdateDeleteAccess"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "ivari.webcappow"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://pplus-service/RestCreateProducerAccess"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "ivari.advisor-econtracting"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://search-services/Policy",
                    "https://search-services/Client",
                    "https://eclipse-service/RetrieveImageWithDocKey",
                    "https://secure-document-service/DocumentAccess",
                    "https://pplus-service/RestReadAccess",
                    "https://wma-services/RestReadAccess",
                    "https://wma-services/RestCreateUpdateDeleteAccess"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "ivari.myivari"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://search-services/Policy",
                    "https://search-services/Client",
                    "https://ace-api/FullAccess"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.awd"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://document-intake-service/Standard",
                    "https://document-intake-service/Internal",
                    "https://secure-document-service/DocumentAccess"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.uwpro"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://document-intake-service/Standard",
                    "https://document-intake-service/Internal",
                    "https://secure-document-service/DocumentAccess"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.illustration-pro"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://eclipse-service/RetrieveImageWithDocKey"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.secure-document-service"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    },
    {
      allowed_oauth_flows                  = ["client_credentials"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_scopes                 = ["https://document-intake-service/Standard",
                    "https://document-intake-service/Internal",
                    "https://secure-document-service/DocumentAccess",
                    "https://secure-document-service/Internal",
                    "https://eclipse-service/RetrieveImageWithDocKey",
                    "https://unia-service/Standard",
                    "https://unia-service/Internal"]
      explicit_auth_flows                  = []
      generate_secret                      = true
      logout_urls                          = []
      name                                 = "bps.test"
      supported_identity_providers         = []
      write_attributes                     = []
      access_token_validity                = 1
      id_token_validity                    = 12
      refresh_token_validity               = 60
      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    }


  ]
}

variable "client_allowed_oauth_flows" {
  description = "The name of the application client"
  type        = list(string)
  default     = []
}

variable "client_allowed_oauth_flows_user_pool_client" {
  description = "Whether the client is allowed to follow the OAuth protocol when interacting with Cognito user pools"
  type        = bool
  default     = true
}

variable "client_allowed_oauth_scopes" {
  description = "List of allowed OAuth scopes (phone, email, openid, profile, and aws.cognito.signin.user.admin)"
  type        = list(string)
  default     = []
}

variable "client_callback_urls" {
  description = "List of allowed callback URLs for the identity providers"
  type        = list(string)
  default     = []
}

variable "client_default_redirect_uri" {
  description = "The default redirect URI. Must be in the list of callback URLs"
  type        = string
  default     = ""
}

variable "client_explicit_auth_flows" {
  description = "List of authentication flows (ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH)"
  type        = list(string)
  default     = []
}

variable "client_generate_secret" {
  description = "Should an application secret be generated"
  type        = bool
  default     = true
}

variable "client_logout_urls" {
  description = "List of allowed logout URLs for the identity providers"
  type        = list(string)
  default     = []
}

variable "client_name" {
  description = "The name of the application client"
  type        = string
  default     = null
}

variable "client_read_attributes" {
  description = "List of user pool attributes the application client can read from"
  type        = list(string)
  default     = []
}

variable "client_prevent_user_existence_errors" {
  description = "Choose which errors and responses are returned by Cognito APIs during authentication, account confirmation, and password recovery when the user does not exist in the user pool. When set to ENABLED and the user does not exist, authentication returns an error indicating either the username or password was incorrect, and account confirmation and password recovery return a response indicating a code was sent to a simulated destination. When set to LEGACY, those APIs will return a UserNotFoundException exception if the user does not exist in the user pool."
  type        = string
  default     = null
}

variable "client_supported_identity_providers" {
  description = "List of provider names for the identity providers that are supported on this client"
  type        = list(string)
  default     = []
}

variable "client_write_attributes" {
  description = "List of user pool attributes the application client can write to"
  type        = list(string)
  default     = []
}

variable "client_access_token_validity" {
  description = "Time limit, between 5 minutes and 1 day, after which the access token is no longer valid and cannot be used. This value will be overridden if you have entered a value in `token_validity_units`."
  type        = number
  default     = 60
}

variable "client_id_token_validity" {
  description = "Time limit, between 5 minutes and 1 day, after which the ID token is no longer valid and cannot be used. Must be between 5 minutes and 1 day. Cannot be greater than refresh token expiration. This value will be overridden if you have entered a value in `token_validity_units`."
  type        = number
  default     = 60
}

variable "client_refresh_token_validity" {
  description = "The time limit in days refresh tokens are valid for. Must be between 60 minutes and 3650 days. This value will be overridden if you have entered a value in `token_validity_units`"
  type        = number
  default     = 30
}

variable "client_token_validity_units" {
  description = "Configuration block for units in which the validity times are represented in. Valid values for the following arguments are: `seconds`, `minutes`, `hours` or `days`."
  type        = any
  default = {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

}

#
# aws_cognito_user_group
#
variable "user_groups" {
  description = "A container with the user_groups definitions"
  type        = list(any)
  default     = []
}

variable "user_group_name" {
  description = "The name of the user group"
  type        = string
  default     = null
}

variable "user_group_description" {
  description = "The description of the user group"
  type        = string
  default     = null
}

variable "user_group_precedence" {
  description = "The precedence of the user group"
  type        = number
  default     = null
}

variable "user_group_role_arn" {
  description = "The ARN of the IAM role to be associated with the user group"
  type        = string
  default     = null
}

#
# aws_cognito_resource_server
#
variable "resource_servers" {
  description = "A container with the user_groups definitions"
  type        = list(any)
  default     = [
    {
      identifier = "https://ace-services"
      name       = "ACE Services"
      scope = [
        {
          scope_name        = "FullAccess"
          scope_description = "Full access to api"
        }
      ]
    },
    {
      identifier = "https://eclipse-service"
      name       = "Eclipse Service"
      scope = [
        {
          scope_name        = "PolicySearch"
          scope_description = "Search documents and read document attributes"
        },
        {
          scope_name        = "RetrieveImageWithDocKey"
          scope_description = "Retrieve images using document key"
        },
        {
          scope_name        = "DocumentIndexing"
          scope_description = "Document Indexing"
        },
        {
          scope_name        = "FullAccess"
          scope_description = "Full access to internal api"
        }
      ]
    },
    {
      identifier = "https://pplus-service"
      name       = "Performance Plus REST Services"
      scope = [
        {
          scope_name        = "RestReadAccess"
          scope_description = "GET Operations across all resources"
        },
        {
          scope_name        = "RestCreateUpdateDeleteAccess"
          scope_description = "POST PUT and DELETE Operations across all resources except Producer"
        },
        {
          scope_name        = "RestCreateProducerAccess"
          scope_description = "POST operation on Producer resource"
        }
      ]
    },
    {
      identifier = "https://search-services"
      name       = "Search Services"
      scope = [
        {
          scope_name        = "Policy"
          scope_description = "Search policy details"
        },
        {
          scope_name        = "Client"
          scope_description = "Search client details"
        }
      ]
    },
    {
      identifier = "https://wma-services"
      name       = "WMA Services"
      scope = [
        {
          scope_name        = "RestReadAccess"
          scope_description = "GET POST Operations across all resources"
        },
        {
          scope_name        = "RestCreateUpdateDeleteAccess"
          scope_description = "PUT PATCH and DELETE Operations across all resources"
        }
      ]
    },
    {
      identifier = "https://ace-api"
      name       = "ACE Api"
      scope = [
        {
          scope_name        = "FullAccess"
          scope_description = "Full access to api"
        }
      ]
    },
    {
      identifier = "https://secure-document-service"
      name       = "Secure Document Service Api"
      scope = [
        {
          scope_name        = "DocumentAccess"
          scope_description = "Access to document retrieval"
        },
        {
          scope_name        = "Internal"
          scope_description = "Allows access to internal utility methods"
        }
      ]
    },
    {
      identifier = "https://document-intake-service"
      name       = "Document Intake Service"
      scope = [
        {
          scope_name        = "Standard"
          scope_description = "Submit documents and check basic item status"
        },
        {
          scope_name        = "Internal"
          scope_description = "Allows checking detailed items status"
        }
      ]
    },
    {
      identifier = "https://unia-service"
      name       = "Unia Service"
      scope = [
        {
          scope_name        = "Standard"
          scope_description = "Access to the standard apis"
        },
        {
          scope_name        = "Internal"
          scope_description = "Access to internal apis"
        }
      ]
    }
    ]
}

variable "resource_server_name" {
  description = "A name for the resource server"
  type        = string
  default     = null
}

variable "resource_server_identifier" {
  description = "An identifier for the resource server"
  type        = string
  default     = null
}

variable "resource_server_scope_name" {
  description = "The scope name"
  type        = string
  default     = null
}

variable "resource_server_scope_description" {
  description = "The scope description"
  type        = string
  default     = null
}

#
# Account Recovery Setting
#
variable "recovery_mechanisms" {
  description = "The list of Account Recovery Options"
  type        = list(any)
  default     = []
}

#
# aws_cognito_identity_provider
#
variable "identity_providers" {
  description = "Cognito Pool Identity Providers"
  type        = list(any)
  default     = []
}



### Not in Use


# admin_create_user_config
variable "admin_create_user_config" {
  description = "The configuration for AdminCreateUser requests"
  type        = map(any)
  default     = {}
}

variable "admin_create_user_config_allow_admin_create_user_only" {
  description = "Set to True if only the administrator is allowed to create user profiles. Set to False if users can sign themselves up via an app"
  type        = bool
  default     = true
}

variable "temporary_password_validity_days" {
  description = "The user account expiration limit, in days, after which the account is no longer usable"
  type        = number
  default     = 7
}

variable "admin_create_user_config_email_message" {
  description = "The message template for email messages. Must contain `{username}` and `{####}` placeholders, for username and temporary password, respectively"
  type        = string
  default     = "{username}, your verification code is `{####}`"
}


variable "admin_create_user_config_email_subject" {
  description = "The subject line for email messages"
  type        = string
  default     = "Your verification code"
}

variable "admin_create_user_config_sms_message" {
  description = "- The message template for SMS messages. Must contain `{username}` and `{####}` placeholders, for username and temporary password, respectively"
  type        = string
  default     = "Your username is {username} and temporary password is `{####}`"
}

variable "alias_attributes" {
  description = "Attributes supported as an alias for this user pool. Possible values: phone_number, email, or preferred_username. Conflicts with `username_attributes`"
  type        = list(string)
  default     = null
}

variable "username_attributes" {
  description = "Specifies whether email addresses or phone numbers can be specified as usernames when a user signs up. Conflicts with `alias_attributes`"
  type        = list(string)
  default     = null
}

variable "auto_verified_attributes" {
  description = "The attributes to be auto-verified. Possible values: email, phone_number"
  type        = list(string)
  default     = []
}

# sms_configuration
variable "sms_configuration" {
  description = "The SMS Configuration"
  type        = map(any)
  default     = {}
}

variable "sms_configuration_external_id" {
  description = "The external ID used in IAM role trust relationships"
  type        = string
  default     = ""
}

variable "sms_configuration_sns_caller_arn" {
  description = "The ARN of the Amazon SNS caller. This is usually the IAM role that you've given Cognito permission to assume"
  type        = string
  default     = ""
}

# device_configuration
variable "device_configuration" {
  description = "The configuration for the user pool's device tracking"
  type        = map(any)
  default     = {}
}

variable "device_configuration_challenge_required_on_new_device" {
  description = "Indicates whether a challenge is required on a new device. Only applicable to a new device"
  type        = bool
  default     = false
}

variable "device_configuration_device_only_remembered_on_user_prompt" {
  description = "If true, a device is only remembered on user prompt"
  type        = bool
  default     = false
}

# email_configuration
variable "email_configuration" {
  description = "The Email Configuration"
  type        = map(any)
  default     = {}
}

variable "email_configuration_reply_to_email_address" {
  description = "The REPLY-TO email address"
  type        = string
  default     = ""
}

variable "email_configuration_source_arn" {
  description = "The ARN of the email source"
  type        = string
  default     = ""
}

variable "email_configuration_email_sending_account" {
  description = "Instruct Cognito to either use its built-in functional or Amazon SES to send out emails. Allowed values: `COGNITO_DEFAULT` or `DEVELOPER`"
  type        = string
  default     = "COGNITO_DEFAULT"
}

variable "email_configuration_from_email_address" {
  description = "Sender’s email address or sender’s display name with their email address (e.g. `john@example.com`, `John Smith <john@example.com>` or `\"John Smith Ph.D.\" <john@example.com>)`. Escaped double quotes are required around display names that contain certain characters as specified in RFC 5322"
  type        = string
  default     = null
}

# lambda_config
variable "lambda_config" {
  description = "A container for the AWS Lambda triggers associated with the user pool"
  type        = any
  default     = null
}

variable "lambda_config_create_auth_challenge" {
  description = "The ARN of the lambda creating an authentication challenge."
  type        = string
  default     = ""
}

variable "lambda_config_custom_message" {
  description = "A custom Message AWS Lambda trigger."
  type        = string
  default     = ""
}

variable "lambda_config_define_auth_challenge" {
  description = "Defines the authentication challenge."
  type        = string
  default     = ""
}

variable "lambda_config_post_authentication" {
  description = "A post-authentication AWS Lambda trigger"
  type        = string
  default     = ""
}

variable "lambda_config_post_confirmation" {
  description = "A post-confirmation AWS Lambda trigger"
  type        = string
  default     = ""
}

variable "lambda_config_pre_authentication" {
  description = "A pre-authentication AWS Lambda trigger"
  type        = string
  default     = ""
}
variable "lambda_config_pre_sign_up" {
  description = "A pre-registration AWS Lambda trigger"
  type        = string
  default     = ""
}

variable "lambda_config_pre_token_generation" {
  description = "Allow to customize identity token claims before token generation"
  type        = string
  default     = ""
}

variable "lambda_config_user_migration" {
  description = "The user migration Lambda config type"
  type        = string
  default     = ""
}

variable "lambda_config_verify_auth_challenge_response" {
  description = "Verifies the authentication challenge response"
  type        = string
  default     = ""
}

variable "lambda_config_kms_key_id" {
  description = "The Amazon Resource Name of Key Management Service Customer master keys. Amazon Cognito uses the key to encrypt codes and temporary passwords sent to CustomEmailSender and CustomSMSSender."
  type        = string
  default     = null
}

variable "lambda_config_custom_email_sender" {
  description = "A custom email sender AWS Lambda trigger."
  type        = map(any)
  default     = {}
}

variable "lambda_config_custom_sms_sender" {
  description = "A custom SMS sender AWS Lambda trigger."
  type        = map(any)
  default     = {}
}

variable "mfa_configuration" {
  description = "Set to enable multi-factor authentication. Must be one of the following values (ON, OFF, OPTIONAL)"
  type        = string
  default     = "OFF"
}

# software_token_mfa_configuration
variable "software_token_mfa_configuration" {
  description = "Configuration block for software token MFA (multifactor-auth). mfa_configuration must also be enabled for this to work"
  type        = map(any)
  default     = {}
}

variable "software_token_mfa_configuration_enabled" {
  description = "If true, and if mfa_configuration is also enabled, multi-factor authentication by software TOTP generator will be enabled"
  type        = bool
  default     = false
}

# password_policy
variable "password_policy" {
  description = "A container for information about the user pool password policy"
  type = object({
    minimum_length                   = number,
    require_lowercase                = bool,
    require_lowercase                = bool,
    require_numbers                  = bool,
    require_symbols                  = bool,
    require_uppercase                = bool,
    temporary_password_validity_days = number
  })
  default = null
}

variable "password_policy_minimum_length" {
  description = "The minimum length of the password policy that you have set"
  type        = number
  default     = 8
}

variable "password_policy_require_lowercase" {
  description = "Whether you have required users to use at least one lowercase letter in their password"
  type        = bool
  default     = true
}

variable "password_policy_require_numbers" {
  description = "Whether you have required users to use at least one number in their password"
  type        = bool
  default     = true
}

variable "password_policy_require_symbols" {
  description = "Whether you have required users to use at least one symbol in their password"
  type        = bool
  default     = true
}

variable "password_policy_require_uppercase" {
  description = "Whether you have required users to use at least one uppercase letter in their password"
  type        = bool
  default     = true
}

variable "password_policy_temporary_password_validity_days" {
  description = "The minimum length of the password policy that you have set"
  type        = number
  default     = 7
}

# schema
variable "schemas" {
  description = "A container with the schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default     = []
}

variable "string_schemas" {
  description = "A container with the string schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default     = []
}

variable "number_schemas" {
  description = "A container with the number schema attributes of a user pool. Maximum of 50 attributes"
  type        = list(any)
  default     = []
}

# sms messages
variable "sms_authentication_message" {
  description = "A string representing the SMS authentication message"
  type        = string
  default     = null
}

variable "sms_verification_message" {
  description = "A string representing the SMS verification message"
  type        = string
  default     = null
}
