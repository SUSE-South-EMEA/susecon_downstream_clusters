resource "rancher2_cloud_credential" "azure_rancher_credentials" {
  name = "Azure_Credentials"
  description = "Azure Credentials for creating or importing clusters"

  provider = rancher2.admin

  azure_credential_config {
    client_id = var.azure_client_id
    client_secret = var.azure_client_secret
    subscription_id = var.azure_subscription_id
  }
}

resource "rancher2_machine_config_v2" "azure_downstream_cluster" {
  depends_on = [
    rancher2_cloud_credential.azure_rancher_credentials
  ]

  provider = rancher2.admin

  generate_name = "downstream-cluster-azure"
  azure_config {
    static_public_ip = true
  }
  
}

resource "rancher2_cluster_v2" "azure_downstream_cluster" {
  depends_on = [
    rancher2_machine_config_v2.azure_downstream_cluster,
    rancher2_cloud_credential.azure_rancher_credentials
  ]

  provider = rancher2.admin

  name = "downstream-cluster-azure"
  kubernetes_version = var.kube_version

  rke_config {
    machine_pools {
      name = "downstream-cluster-pool-azure"
      cloud_credential_secret_name = rancher2_cloud_credential.azure_rancher_credentials.id
      control_plane_role = true
      etcd_role = true
      worker_role = true
      quantity = 3
      machine_config {
        kind = rancher2_machine_config_v2.azure_downstream_cluster.kind
        name = rancher2_machine_config_v2.azure_downstream_cluster.name
      }
    }
  }
}

