terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.2.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.23.0"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "1.2.0"
    }
  }
  required_version = ">= 1.0.0"
}
