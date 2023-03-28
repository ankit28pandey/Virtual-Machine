variable "location" {
  description = "The Azure region in which to create the instance."
  type = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the instance."
  type = string
}

variable "storage_account_type" {
  description = "The storage account type"
  type = string
}

variable "azurerm_network_interface" {
  description = "The network interface of the azure account"
  type = string
}

variable "subnet_name" {
  description = "The name of the subnet to create the instance"
  type = string
}

variable "vm_name" {
  description = "The name of the Azure virtual machine."
  type = string
}

variable "vm_size" {
  description = "The size of the Azure virtual machine."
  type = string
}

variable "admin_username" {
  description = "The username of the Azure virtual machine admin."
  type = string
}

variable "admin_password" {
  description = "The password of the Azure virtual machine admin."
  type = string
}

variable "admin_ssh_key" {
  description = "The ssh key require  to login into the azure account"
  type = string
  default = "../.ssh/id_rsa.pub"
}

variable "azurerm_network_security_group" {
  description = "The variable used for the networking of the instance"
  type = string
}

variable "client_id" {
    description = "The client id of your azure account"
    type = string
}

variable "subscription_id" {
    description = "The subscription id of your azure account"
    type = string
}

variable "client_secret" {
    description = "The client secret of your azure account"
    type = string
}

variable "tenant_id" {
    description = "The tenant id of your azure account"
    type = string
}