### Backend definition

# terraform {
#   # The configuration for this backend will be filled in by Terragrunt
#   backend "s3" {}
# }

### Module Main

data "aws_caller_identity" "current" {}

### VPC

data "aws_vpc" "vpc" {
  tags = [
    {
      Name = "${var.vpc_name}-vpc"
    },
  ]
}

### Subnets

# VPC private tier subnets
data "aws_subnet_ids" "vpc_private_subnets" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Tier = "private"
  }
}

# VPC private tier subnets azs information
data "aws_subnet" "vpc_private_subnets_info" {
  count = "${length(data.aws_subnet_ids.vpc_private_subnets.ids)}"
  id    = "${element(data.aws_subnet_ids.vpc_private_subnets.ids, count.index)}"
}

# VPC public tier subnets
data "aws_subnet_ids" "vpc_public_subnets" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Tier = "public"
  }
}

# VPC public tier subnets azs information
data "aws_subnet" "vpc_public_subnets_info" {
  count = "${length(data.aws_subnet_ids.vpc_public_subnets.ids)}"
  id    = "${element(data.aws_subnet_ids.vpc_public_subnets.ids, count.index)}"
}

# VPC on-demand subnets
data "aws_subnet" "vpc_subnets" {
  count  = "${length(var.vpc_subnets)}"
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Name = "${element(var.vpc_subnets, count.index)}"
  }
}

### Route tables

# VPC private route table information
data "aws_route_table" "vpc_private_route_table_info" {
  count  = "${length(data.aws_subnet.vpc_private_subnets_info.*.id)}"
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Name = "${var.vpc_name}-private-${element(data.aws_subnet.vpc_private_subnets_info.*.availability_zone, count.index)}"
  }
}

# VPC public route table information
data "aws_route_table" "vpc_public_route_table_info" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Name = "${var.vpc_name}-public"
  }
}

### NAT gateways

# data "aws_nat_gateway" "vpc_nat_gateway_info" {
#   count  = "${length(distinct(data.aws_subnet.vpc_private_subnets_info.*.availability_zone))}"
#   vpc_id = "${data.aws_vpc.vpc.id}"

#   filter {
#     name   = "tag:Name"
#     values = ["${var.vpc_name}-nat-${element(data.aws_subnet.vpc_private_subnets_info.*.availability_zone, count.index)}"]
#   }
# }

### EC2

data "aws_security_group" "ec2_security_groups" {
  count  = "${length(var.ec2_security_groups)}"
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Name = "${var.aws_region_code == "" ? "" : "${var.aws_region_code}-"}${element(var.ec2_security_groups, count.index)}"
  }
}

### AMI

data "aws_ami" "ec2_amis" {
  count       = "${length(var.ec2_ami_names)}"
  most_recent = true
  owners      = ["${var.ec2_ami_owners}"]

  filter {
    name   = "name"
    values = ["${element(var.ec2_ami_names, count.index)}"]
  }
}

### IAM

data "aws_iam_role" "iam_role" {
  count = "${length(var.iam_role_names)}"
  name  = "${element(var.iam_role_names, count.index)}"
}

### R53

data "aws_route53_zone" "r53_zones" {
  count = "${length(var.r53_hosted_zones)}"
  name  = "${element(var.r53_hosted_zones, count.index)}"
}
