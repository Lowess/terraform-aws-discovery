# :crystal_ball: terraform-aws-discovery

## Guidelines

In order to make this discovery module work, the following naming convention should be adopted:

---

### Common variables referenced in naming standards

| Variable              | RegExp                          | Example                                  |
|:----------------------|:--------------------------------|:-----------------------------------------|
| `<availability_zone>` | `[a-z]{2}-[a-z]{1,}-[1-2][a-f]` | `us-east-1a`, `us-west-2c`, `eu-west-1a` |

---

### VPC Resources Naming Standards

| AWS Resource         | Resource Naming                          | Comment             | Example                      |
|:---------------------|:-----------------------------------------|:--------------------|:-----------------------------|
| VPC                  | `<vpc_name>-vpc`                         |                     | `mycloud`                    |
| Private Subnets      | `<vpc_name>-private-<availability_zone>` | `Tag: Tier=private` | `mycloud-private-us-east-1b` |
| Public Subnets       | `<vpc_name>-public-<availability_zone>`  | `Tag: Tier=public`  | `mycloud-public`             |
| Private Route Tables | `<vpc_name>-private-<availability_zone>` |                     | `mycloud-private-us-east-1b` |
| Public Route Tables  | `<vpc_name>-public`                      |                     | `mycloud-public`             |
| Nat Gateway          | `<vpc_name>-nat-<availability_zone>`     |                     | `mycloud-nat-us-east-1b`     |
| Internet Gateway     | `<vpc_name>-igw`                         |                     | `mycloud-igw`                |

## Inputs

| Name                | Description                                                    |  Type  | Default  | Required |
|:--------------------|:---------------------------------------------------------------|:------:|:--------:|:--------:|
| aws_region          |                                                                | string |    -     |   yes    |
| aws_region_code     | The region code used to prefix resources, if any               | string |    ``    |    no    |
| ec2_security_groups | List of security groups you want to discover information about |  list  | `<list>` |    no    |
| iam_role_names      | List of IAM role names you want to discover information about  |  list  | `<list>` |    no    |
| image_names         | List of AMI names you want to discover information about       |  list  | `<list>` |    no    |
| r53_hosted_zones    | A list of strings of hosted zones, if any                      |  list  | `<list>` |    no    |
| vpc_name            | Name of the VPC you want to discover information about         | string |    -     |   yes    |
| vpc_subnets         | List of subnets names you want to discover information about   |  list  | `<list>` |    no    |

