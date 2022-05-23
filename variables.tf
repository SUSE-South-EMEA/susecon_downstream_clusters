# Required
variable "rancher_server_location" {
  type        = string
  description = "Rancher Server location"
}

variable "rancher_token" {
  type        = string
  description = "Rancher token"
}

variable "aws_vpc" {
  type        = string
  description = "AWS VPC"
}

variable "aws_access_key" {
  type        = string
  description = "AWS access key used to create infrastructure"
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key used to create AWS infrastructure"
}

variable "aws_session_token" {
  type        = string
  description = "AWS session token used to create AWS infrastructure"
  default     = ""
}

variable "aws_region" {
  type        = string
  description = "AWS region used for rancher resources"
  default     = "eu-central-1"
}

variable "kube_version" {
  type        = string
  description = "Kubernetes RKE2 version for downstream clusters"
  default     = "v1.23.5+k3s1"
}

variable "kube_config_location" {
  type        = string
  description = "Location of ssh key needed for access"
  default     = "./kube_config_cluster.yml"
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription id used to create infrastructure"
}

variable "azure_client_id" {
  type        = string
  description = "Azure client id used to create infrastructure"
}

variable "azure_client_secret" {
  type        = string
  description = "Azure client secret used to create AWS infrastructure"
}

