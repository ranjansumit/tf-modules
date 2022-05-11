module "aws_backup_example" {

  source = "../../modules/awsbackup"

  # Vault
  vault_name = var.vault_name

  # Plan
  plan_name = var.plan_name

  backup_policy= var.backup_policy

  # Multiple rules using a list of maps
  rules = [
    {
      name              = var.rule_name
      schedule          = var.rule_schedule
      target_vault_name = var.vault_name
      start_window      = var.rule_start_window
      completion_window = var.rule_completion_window
      lifecycle = {
        delete_after    = var.rule_lifecycle_delete_after
      },
      recovery_point_tags = var.rule_recovery_point_tags
    }
  ]

  # Multiple selections
  #  - Selection-1: By tags: Environment = prod, Owner = devops
  selections = [
    {
      name = var.selection_name
      selection_tags = var.selection_tags
    }
  ]

  tags = var.tags

}
