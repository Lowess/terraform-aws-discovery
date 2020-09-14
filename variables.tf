variable "aws_region" {
  type = string
}

variable "aws_region_code" {
  description = "The region code used to prefix resources, if any"
  default     = ""
}

variable "r53_hosted_zones" {
  type        = list(string)
  description = "A list of strings of hosted zones, if any"
  default     = []
}

variable "discovery_tag_key" {
  type        = string
  description = "The tag key on which data lookups should be made"
  default     = "Name"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC you want to discover information about"
}

variable "vpc_subnets" {
  type        = list(string)
  description = "List of subnets names you want to discover information about"
  default     = []
}

variable "ec2_security_groups" {
  type        = list(string)
  description = "List of security groups you want to discover information about"
  default     = []
}

variable "iam_role_names" {
  type        = list(string)
  description = "List of IAM role names you want to discover information about"
  default     = []
}

variable "ec2_ami_names" {
  type        = list(string)
  description = "List of AMI names you want to discover information about"
  default     = []
}

variable "ec2_ami_owners" {
  type        = string
  description = "Owner of the AMI"
  default     = "750996176928"
}

