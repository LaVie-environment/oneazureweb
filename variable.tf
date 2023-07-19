variable "resource_group_name" {
    type = string
    description = "Resource Group name in Azure"
}

variable "location" {
    type = string
    description = "Resource location in Azure"
}

variable "subscription_id" {
    description = "Azure subscription"
}

variable "client_id" {
    description = "Azure Client ID"
}

variable "client_secret" {
   description = "Azure Client Secret"
}

variable "tenant_id" {
   description = "Azure Tenant ID"
}

variable "instance_size" {
   type = string
   description = "Azure instance size"
}


variable "environment" {
   type = string
   description = "Environment"
   
}