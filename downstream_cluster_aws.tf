resource "rancher2_cloud_credential" "aws_rancher_credentials" {
  name = "AWS_Credentials"
  description = "AWS Credentials for creating or importing clusters"

  provider = rancher2.admin

  amazonec2_credential_config {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}


resource "rancher2_machine_config_v2" "aws_downstream_cluster" {
  depends_on = [
    rancher2_cloud_credential.aws_rancher_credentials
  ]

  provider = rancher2.admin

  generate_name = "downstream-cluster-aws"
  amazonec2_config {
    ami = data.aws_ami.sles.id
    region = var.aws_region
    security_group = [aws_security_group.allow-all-downstream.name]
    subnet_id = data.aws_subnet.aws_first_subnet.id
    vpc_id = var.aws_vpc
    zone = substr(data.aws_subnet.aws_first_subnet.availability_zone, -1, -1)
    ssh_user = "ec2-user"
    instance_type = "t2.medium"
  }
}

resource "rancher2_cluster_v2" "aws_downstream_cluster" {
  depends_on = [
    rancher2_machine_config_v2.aws_downstream_cluster,
    rancher2_cloud_credential.aws_rancher_credentials
  ]

  provider = rancher2.admin

  name = "downstream-cluster-aws"
  kubernetes_version = var.kube_version

  rke_config {
    machine_pools {
      name = "downstream-cluster-pool-aws"
      cloud_credential_secret_name = rancher2_cloud_credential.aws_rancher_credentials.id
      control_plane_role = true
      etcd_role = true
      worker_role = true
      quantity = 3
      machine_config {
        kind = rancher2_machine_config_v2.aws_downstream_cluster.kind
        name = rancher2_machine_config_v2.aws_downstream_cluster.name
      }
    }
  }
}

