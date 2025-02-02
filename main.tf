module "rgroup-n01655478" {
  source = "./modules/rgroup-n01655478"

  network_rg_name = "n01655478-RG"
  location        = "Canada Central"
  common_tags     = var.common_tags
}

module "network-n01655478" {
  source = "./modules/network-n01655478"

  network_rg_name               = module.rgroup-n01655478.network_rg
  location                      = module.rgroup-n01655478.location
  virtual_network_name          = "n01655478-VNET"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_name                   = "n01655478-SUBNET"
  subnet_address                = ["10.0.0.0/24"]
  network_security_group_name   = "n01655478-NSG"
  common_tags                   = var.common_tags
}

module "common-n01655478" {
  source = "./modules/common-n01655478"

  location                     = module.rgroup-n01655478.location
  network_rg_name              = module.rgroup-n01655478.network_rg
  log_analytics_workspace_name = "n01655478-log-analytics-workspace"
  recovery_services_vault_name = "n01655478-recovery-service-vault"
  storage_account_name         = "n01655478sa"
  common_tags                  = var.common_tags
}

module "vmlinux-n01655478" {
  source = "./modules/vmlinux-n01655478"

  linux_name = { "n01655478-c-vm1" : "Standard_B1ms",
    "n01655478-c-vm2" : "Standard_B1ms",
    "n01655478-c-vm3" : "Standard_B1ms" }
  vm_size                      = "Standard_B1ms"
  admin_username               = "n01655478"
  public_key_path              = "/home/n01655478/.ssh/id_rsa.pub"
  private_key_path             = "/home/n01655478/.ssh/id_rsa"
  os_disk_storage_account_type = "Standard_LRS"
  os_disk_size                 = 32
  os_disk_caching              = "ReadWrite"
  os_publisher                 = "OpenLogic"
  os_offer                     = "CentOS"
  os_sku                       = "8_2"
  os_version                   = "latest"
  linux_avs                    = "n01655478-linux-avs"
  location                     = module.rgroup-n01655478.location
  network_rg_name              = module.rgroup-n01655478.network_rg
  subnet_id                    = module.network-n01655478.subnet_id
  storage_account_uri          = module.common-n01655478.storage_account_uri
  common_tags                  = var.common_tags
}

module "vmwindows-n01655478" {
  source = "./modules/vmwindows-n01655478"

  windows_admin_username               = "n01655478"
  windows_admin_password               = "N@01655478"
  windows_os_disk_storage_account_type = "StandardSSD_LRS"
  windows_os_disk_size                 = 128
  windows_os_disk_caching              = "ReadWrite"
  windows_os_publisher                 = "MicrosoftWindowsServer"
  windows_os_offer                     = "WindowsServer"
  windows_os_sku                       = "2016-Datacenter"
  windows_os_version                   = "latest"
  windows_avs                          = "n01655478-windows-avs"
  windows_name                         = "n01655478-w-vm"
  windows_size                         = "Standard_B1ms"
  network_rg_name                      = module.rgroup-n01655478.network_rg
  location                             = module.rgroup-n01655478.location
  subnet_id                            = module.network-n01655478.subnet_id
  nb_count                             = 1
  common_tags                          = var.common_tags
}

module "datadisk-n01655478" {
  source = "./modules/datadisk-n01655478"

  vm_ids          = concat(module.vmlinux-n01655478.linux_id, module.vmwindows-n01655478.windows_id)
  network_rg_name = module.rgroup-n01655478.network_rg
  location        = module.rgroup-n01655478.location
  common_tags     = var.common_tags
}

module "loadbalancer-n01655478" {
  source = "./modules/loadbalancer-n01655478"

  linux_vm_ids   = module.vmlinux-n01655478.linux_id
  linux_nic_ids  = module.vmlinux-n01655478.linux_nic_id
  linux_hostname = module.vmlinux-n01655478.linux_hostname
  resource_group = module.rgroup-n01655478.network_rg
  location       = module.rgroup-n01655478.location
  common_tags    = var.common_tags
}

module "database-n01655478" {
  source = "./modules/database-n01655478"

  network_rg_name = module.rgroup-n01655478.network_rg
  location        = module.rgroup-n01655478.location
  server_name     = "n01655478-postgresql-server"
  admin_username  = "psqladmin"
  admin_password  = "N@01655478"
  database_name   = "n01655478-database"
  common_tags     = var.common_tags
}
