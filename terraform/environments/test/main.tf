provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate2414428313"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
    access_key           = "cya1E/h5xBV0G4R7gV+PYEozCXs82heSp+rDBNEU8F4pbNYA57fZO0of6AnkXfQEyK9It0EeeWYf+AStRezclg=="
  }
}

module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "vnet"
  resource_group       = "${var.resource_group}"
  address_prefixes     = "${var.address_prefixes}"
  address_prefix_test  = "${var.address_prefix_test}"
}

module "nsg-test" {
  source           = "../../modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "nsg"
  resource_group   = "${var.resource_group}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
}

module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "app-service"
  resource_group   = "${var.resource_group}"
}

module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "ip"
  resource_group   = "${var.resource_group}"
}

module "vm" {
  source           = "../../modules/vm"
  location         = "${var.location}"
  resource_group   = "${var.resource_group}"
  resource_type    = "VMSelenium"
  application_type = "${var.application_type}"
  subnet_id        = "${module.network.subnet_id_test}"
  public_ip        = "${module.publicip.public_ip_address_id}"
  admin_username   = "${var.admin_username}"
  admin_password   = "${var.admin_password}"
}
