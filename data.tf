# Use latest RancherOS
data "aws_ami" "rancheros" {
  most_recent = true
  owners      = ["605812595337"] # Rancher
  name_regex  = "^rancheros-v.*-hvm-1"

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


# Use latest SLES 15 SP3 for rancher
data "aws_ami" "sles" {
  most_recent = true
  owners      = ["013907871322"] # SUSE

  filter {
    name   = "name"
    values = ["suse-sles-15-sp3*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}



# Discover subnet IDs.
data "aws_subnets" "aws_subnets" {
  filter {
    name = "vpc-id"
    values = [var.aws_vpc]
  }
}

data "aws_subnet" "aws_first_subnet" {
  id = tolist(data.aws_subnets.aws_subnets.ids)[0]
}
