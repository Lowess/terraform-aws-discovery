variable "aws_region" {
  type = "string"
}

variable "aws_region_code" {
  description = "The region code used to prefix resources, if any"
  default     = ""
}

variable "r53_hosted_zones" {
  type        = "list"
  description = "A list of strings of hosted zones, if any"
  default     = []
}

variable "vpc_name" {
  type        = "string"
  description = "Name of the VPC you want to discover information about"
}

variable "vpc_subnets" {
  type        = "list"
  description = "List of subnets names you want to discover information about"
  default     = []
}

variable "ec2_security_groups" {
  type        = "list"
  description = "List of security groups you want to discover information about"
  default     = []
}

variable "iam_role_names" {
  type        = "list"
  description = "List of IAM role names you want to discover information about"
  default     = []
}

variable "ec2_ami_names" {
  type        = "list"
  description = "List of AMI names you want to discover information about"
  default     = []
}
