### Account outputs

output "aws_account_json" {
  value = "${map(
    "account_id", "${data.aws_caller_identity.current.account_id}",
    "arn", "${data.aws_caller_identity.current.arn}"
  )}"
}

output "aws_account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

### VPC outputs

output "vpc_json" {
  value = "${map(
    "id", "${data.aws_vpc.vpc.id}",
    "cidr_block", "${data.aws_vpc.vpc.cidr_block}",
    "name", "${data.aws_vpc.vpc.tags.Name}"
  )}"
}

output "vpc_id" {
  value = "${data.aws_vpc.vpc.id}"
}

output "vpc_cidr" {
  value = "${data.aws_vpc.vpc.cidr_block}"
}

### Subnets outputs

output "private_subnets" {
  value = "${data.aws_subnet.vpc_private_subnets_info.*.id}"
}

output "public_subnets" {
  value = "${data.aws_subnet.vpc_public_subnets_info.*.id}"
}

output "subnets" {
  value = "${data.aws_subnet.vpc_subnets.*.id}"
}

output "private_subnets_json" {
  value = "${zipmap(
    data.aws_subnet.vpc_private_subnets_info.*.availability_zone,
    data.aws_subnet.vpc_private_subnets_info.*.id
  )}"
}

output "public_subnets_json" {
  value = "${zipmap(
    data.aws_subnet.vpc_public_subnets_info.*.availability_zone,
    data.aws_subnet.vpc_public_subnets_info.*.id
  )}"
}

output "subnets_json" {
  value = "${zipmap(
    data.aws_subnet.vpc_subnets.*.tags.Name,
    data.aws_subnet.vpc_subnets.*.id
  )}"
}

### Route tables outputs
output "private_route_tables" {
  value = "${data.aws_route_table.vpc_private_route_table_info.*.id}"
}

output "private_route_tables_json" {
  value = "${zipmap(
    data.aws_route_table.vpc_private_route_table_info.*.tags.Name,
    data.aws_route_table.vpc_private_route_table_info.*.id
  )}"
}

output "public_route_tables" {
  value = "${data.aws_route_table.vpc_public_route_table_info.id}"
}

output "public_route_tables_json" {
  value = "${zipmap(
    data.aws_route_table.vpc_public_route_table_info.*.tags.Name,
    data.aws_route_table.vpc_public_route_table_info.*.id
  )}"
}

### Security group outputs

output "security_groups" {
  value = "${data.aws_security_group.ec2_security_groups.*.id}"
}

output "security_groups_json" {
  value = "${zipmap(
    data.aws_security_group.ec2_security_groups.*.tags.Name,
    data.aws_security_group.ec2_security_groups.*.id
  )}"
}

### NAT gateway outputs
# output "nat_gateways" {
#   value = "${data.aws_nat_gateway.vpc_nat_gateway_info.*.id}"
# }

# output "nat_gateways_json" {
#   value = "${zipmap(
#     distinct(data.aws_subnet.vpc_private_subnets_info.*.availability_zone),
#     data.aws_nat_gateway.vpc_nat_gateway_info.*.id
#   )}"
# }

### AMIs outputs
output "images_id" {
  value = "${data.aws_ami.ec2_amis.*.id}"
}

output "images_json" {
  value = "${zipmap(
    data.aws_ami.ec2_amis.*.name,
    data.aws_ami.ec2_amis.*.id
  )}"
}

### IAM outputs
output "iam_roles_arn" {
  value = "${data.aws_iam_role.iam_role.*.arn}"
}

output "iam_roles_json" {
  value = "${zipmap(
    data.aws_iam_role.iam_role.*.name,
    data.aws_iam_role.iam_role.*.arn
  )}"
}

### R53 Outputs

output "r53_zones" {
  value = "${zipmap(
    data.aws_route53_zone.r53_zones.*.name,
    data.aws_route53_zone.r53_zones.*.zone_id
  )}"
}
