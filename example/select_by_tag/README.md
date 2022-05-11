# Selection by Tags

This example shows you how to define selection using tags, without `resource` definitions.

## Selection by Tags vs. Conditions

**Tags**
Selection by tags differs from selection by conditions as follows: When you specify more than one condition, you assign all resources that match **AT LEAST ONE condition** (using `OR` logic).  Selection by tags only supports `StringEquals`. Conditions supports `StringEquals`, `StringLike`, `StringNotEquals`, and `StringNotLike`.

**Conditions**

Selection by conditions differs from selection by tags as follows: When you specify more than one condition, you only assign the resources that match **ALL conditions** (using `AND` logic).  Selection by conditions supports `StringEquals`, `StringLike`, `StringNotEquals`, and `StringNotLike`. Selection by tags only supports `StringEquals`.

```
module "aws_backup_example" {

  source = "lgallard/backup/aws"

  # Vault
  vault_name = "vault-4"

  # Plan
  plan_name = "selection-tags-plan"

  # Multiple rules using a list of maps
  rules = [
    {
      name              = "rule-1"
      schedule          = "cron(0 12 * * ? *)"
      target_vault_name = null
      start_window      = 120
      completion_window = 360
      lifecycle = {
        cold_storage_after = 0
        delete_after       = 90
      },
      recovery_point_tags = {
        Environment = "prod"
      }
    },
    {
      name                = "rule-2"
      schedule            = "cron(0 7 * * ? *)"
      target_vault_name   = "Default"
      schedule            = null
      start_window        = 120
      completion_window   = 360
      lifecycle           = {}
      copy_action         = {}
      recovery_point_tags = {}
    },
  ]

  # Multiple selections
  #  - Selection-1: By tags: Environment = prod, Owner = devops
  selections = [
    {
      name      = "selection-1"
      selection_tags = [
        {
          type  = "STRINGEQUALS"
          key   = "Environment"
          value = "production"
        },
        {
          type  = "STRINGEQUALS"
          key   = "Owner"
          value = "devops"
        }
      ]
    }
  ]

  tags = {
    Owner       = "devops"
    Environment = "prod"
    Terraform   = true
  }

}
```
