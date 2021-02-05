### Provider definition

provider "aws" {
  region = var.aws_region
}

### Module Main

data "aws_caller_identity" "current" {}

### VPC

data "aws_vpc" "vpc" {
  tags = map(var.discovery_tag_key, "${var.vpc_name}-vpc")
}

data "aws_availability_zones" "azs" {
  state = "available"
}

### Subnets

# VPC private tier subnets
data "aws_subnet_ids" "vpc_private_subnets" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name = "tag:${var.discovery_tag_key}"
    values = [
      for az in data.aws_availability_zones.azs.names : "${var.vpc_name}-private-${az}"
    ]
  }
}

# VPC private tier subnets azs information
data "aws_subnet" "vpc_private_subnets_info" {
  for_each = data.aws_subnet_ids.vpc_private_subnets.ids
  id       = each.value
}

# VPC public tier subnets
data "aws_subnet_ids" "vpc_public_subnets" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name = "tag:${var.discovery_tag_key}"
    values = [
      for az in data.aws_availability_zones.azs.names : "${var.vpc_name}-public-${az}"
    ]
  }
}

# VPC public tier subnets azs information
data "aws_subnet" "vpc_public_subnets_info" {
  for_each = data.aws_subnet_ids.vpc_public_subnets.ids
  id       = each.value
}

# VPC on-demand subnets
data "aws_subnet" "vpc_subnets" {
  for_each = toset(var.vpc_subnets)
  vpc_id   = data.aws_vpc.vpc.id

  tags = {
    (var.discovery_tag_key) = each.value
  }
}

### Route tables

# VPC private route table information
data "aws_route_table" "vpc_private_route_table_info" {
  for_each  = data.aws_subnet_ids.vpc_private_subnets.ids
  subnet_id = each.value
}

# VPC public route table information
data "aws_route_table" "vpc_public_route_table_info" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    (var.discovery_tag_key) = "${var.vpc_name}-public"
  }
}

### EC2

data "aws_security_group" "ec2_security_groups" {
  for_each = toset(var.ec2_security_groups)
  vpc_id   = data.aws_vpc.vpc.id

  tags = map(
    var.discovery_tag_key,
    each.value
  )
}

### AMI

data "aws_ami" "ec2_amis" {
  for_each    = toset(var.ec2_ami_names)
  most_recent = true
  owners      = [var.ec2_ami_owners]

  filter {
    name   = "name"
    values = [each.value]
  }
}
