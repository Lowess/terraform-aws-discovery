# :crystal_ball: terraform-aws-discovery

## Guidelines

In order to make use of this discovery module, please make sure that `discovery_tag_key` follows the naming convention defined in the tables bellow.

### VPC Resources Naming Standards

* The `<availability_zone>`  variable should follow AWS naming convention (`us-east-1a`, `us-west-2c`, `eu-west-1a`)

| AWS Resource         | Resource Naming                          | Comment | Example                      |
|----------------------|------------------------------------------|---------|------------------------------|
| VPC                  | `<vpc_name>-vpc`                         |         | `mycloud`                    |
| Private Subnets      | `<vpc_name>-private-<availability_zone>` |         | `mycloud-private-us-east-1b` |
| Public Subnets       | `<vpc_name>-public-<availability_zone>`  |         | `mycloud-public-us-east-1b`  |
| Private Route Tables | `<vpc_name>-private-<availability_zone>` |         | `mycloud-private-us-east-1b` |
| Public Route Tables  | `<vpc_name>-public`                      |         | `mycloud-public`             |
| Nat Gateway          | `<vpc_name>-nat-<availability_zone>`     |         | `mycloud-nat-us-east-1b`     |
| Internet Gateway     | `<vpc_name>-igw`                         |         | `mycloud-igw`                |

## Inputs

| Name                | Description                                                    | Type   | Default        | Required |
|---------------------|----------------------------------------------------------------|--------|----------------|----------|
| discovery_tag_key   | The tag key on which data lookups should be made               | string | `Name`         |          |
| aws_region          | The aws region where resources are located in                  | string | -              | yes      |
| aws_region_code     | The region code used to prefix resources, if any               | string | ``             | no       |
| ec2_ami_names       | List of AMI names you want to discover information about       | list   | `<list>`       | no       |
| ec2_ami_owners      | Owner of the AMI                                               | string | `750996176928` | no       |
| ec2_security_groups | List of security groups you want to discover information about | list   | `<list>`       | no       |
| iam_role_names      | List of IAM role names you want to discover information about  | list   | `<list>`       | no       |
| r53_hosted_zones    | A list of strings of hosted zones, if any                      | list   | `<list>`       | no       |
| vpc_name            | Name of the VPC you want to discover information about         | string | -              | yes      |
| vpc_subnets         | List of subnets names you want to discover information about   | list   | `<list>`       | no       |

## Outputs example

```ini
aws_account_id = 647925xxxxxx
aws_account_json = {
  account_id = 647925684058
  arn = arn:aws:sts::647925xxxxxx:assumed-role/vocstartsoft/user122465
}
iam_roles_arn = []
iam_roles_json = {}
images_id = [
    ami-0d880934990aec513
]
images_json = {
  api-001 = ami-0d880934990aec513
}
private_route_tables = [
    rtb-01b270ad79152f402,
    rtb-00a8de3e52704c4a7,
    rtb-03a8db929aff494ce
]
private_route_tables_json = {
  ccm-private-us-east-1a = rtb-03a8db929aff494ce
  ccm-private-us-east-1b = rtb-00a8de3e52704c4a7
  ccm-private-us-east-1c = rtb-01b270ad79152f402
}
private_subnets = [
    subnet-0f13de6315441c6fa,
    subnet-045a3de2c1f8331e9,
    subnet-00770179ed66420dd
]
private_subnets_json = {
  us-east-1a = subnet-00770179ed66420dd
  us-east-1b = subnet-045a3de2c1f8331e9
  us-east-1c = subnet-0f13de6315441c6fa
}
public_route_tables = rtb-0ea9c18d6a27aee99
public_route_tables_json = {
  ccm-public = rtb-0ea9c18d6a27aee99
}
public_subnets = [
    subnet-0caa9ffa8a2546dcd,
    subnet-09403fc02c4028d71,
    subnet-0dd245b7c51b36feb
]
public_subnets_json = {
  us-east-1a = subnet-0dd245b7c51b36feb
  us-east-1b = subnet-0caa9ffa8a2546dcd
  us-east-1c = subnet-09403fc02c4028d71
}
r53_zones = {}
security_groups = [
    sg-01d8a9347b6d92d8f
]
security_groups_json = {
  ops = sg-01d8a9347b6d92d8f
}
subnets = []
subnets_json = {}
vpc_cidr = 172.20.0.0/16
vpc_id = vpc-0e8c3e8785f17a0e4
vpc_json = {
  cidr_block = 172.20.0.0/16
  id = vpc-0e8c3e8785f17a0e4
  name = ccm-vpc
}
```
