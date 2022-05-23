provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
  region     = var.aws_region
}

provider "helm" {
  kubernetes {
    config_path = var.kube_config_location
  }
}


# Rancher2 administration provider
provider "rancher2" {
  alias = "admin"

  api_url  = var.rancher_server_location
  insecure = true
  # ca_certs  = data.kubernetes_secret.rancher_cert.data["ca.crt"]
  token_key = var.rancher_token
}