## Account outputs
output "aws_account_json" {
  value = tomap({
    "account_id" = data.aws_caller_identity.current.account_id
    "arn"        = data.aws_caller_identity.current.arn
  })
}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

## VPC outputs
output "vpc_json" {
  value = tomap({
    "id"         = data.aws_vpc.vpc.id
    "cidr_block" = data.aws_vpc.vpc.cidr_block
    "name"       = data.aws_vpc.vpc.tags.Name
  })
}

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = data.aws_vpc.vpc.cidr_block
}

# Subnets outputs
output "private_subnets" {
  value = [for key, val in data.aws_subnet.vpc_private_subnets_info : val.id]
}

output "public_subnets" {
  value = [for key, val in data.aws_subnet.vpc_public_subnets_info : val.id]
}

output "subnets" {
  value = [for key, val in data.aws_subnet.vpc_subnets : val.id]
}

output "subnets_azs" {
  value = [for key, val in data.aws_subnet.vpc_subnets : val.availability_zone]
}

output "private_subnets_json" {
  value = { for key, val in data.aws_subnet.vpc_private_subnets_info : val.availability_zone => val.id }
}

output "public_subnets_json" {
  value = { for key, val in data.aws_subnet.vpc_public_subnets_info : val.availability_zone => val.id... }
}

output "subnets_json" {
  value = { for key, val in data.aws_subnet.vpc_subnets : lookup(val.tags, var.discovery_tag_key) => val.id }
}

output "subnets_azs_json" {
  value = { for key, val in data.aws_subnet.vpc_subnets : lookup(val.tags, var.discovery_tag_key) => val.availability_zone }
}

## Route table outputs
output "public_route_table" {
  value = data.aws_route_table.vpc_public_route_table_info.id
}

output "private_route_tables_json" {
  value = { for key, val in data.aws_route_table.vpc_private_route_table_info : lookup(val.tags, var.discovery_tag_key) => val.id }
}

## Security group outputs
output "security_groups" {
  value = [for val in data.aws_security_group.ec2_security_groups : val.id]
}

output "security_groups_json" {
  value = { for key, val in data.aws_security_group.ec2_security_groups : lookup(val.tags, var.discovery_tag_key) => val.id }
}

## AMIs outputs
output "images_id" {
  value = [for val in data.aws_ami.ec2_amis : val.id]
}

output "images_json" {
  value = { for val in data.aws_ami.ec2_amis : val.name => val.id }
}
