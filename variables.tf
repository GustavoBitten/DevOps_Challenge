#Azure authentication variables - by service principal

variable "azure_subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}
variable "azure_client_id" {
  type        = string
  description = "Azure Client ID"
}
variable "azure_client_secret" {
  type        = string
  description = "Azure Client Secret"
}
variable "azure_tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}

# common variables
variable "location" {
  type        = string
  description = "Location to deploy resources"
  default     = "eastus"

}

# network variables
variable "vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
  default     = "10.10.0.0/16"
}

variable "webserver-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
  default     = "10.10.1.0/24"
}

# virtual machine variables

variable "webserver_size" {
  type        = string
  description = "Size of the virtual machine to create"
  default     = "Standard_B2s"
}
variable "webserver_admin_username" {
  description = "Username for Virtual Machine administrator account"
  type        = string
}
variable "webserver_admin_password" {
  description = "Password for Virtual Machine administrator account"
  type        = string
}

variable "ubuntu-publisher" {
  type        = string
  description = "Publisher ID for Ubuntu Linux"
  default     = "Canonical"
}
variable "ubuntu-offer" {
  type        = string
  description = "Offer ID for Ubuntu Linux"
  default     = "UbuntuServer"
}



