variable "location" {}

variable "network_rg_name" {}

variable "log_analytics_workspace_name" {
  default = "n01655478-log-analytics-workspace"
}

variable "recovery_services_vault_name" {
  default = "n01655478-recovery-service-vault"
}

variable "storage_account_name" {
  default = "n01655478sa"
}

variable "common_tags" {}
