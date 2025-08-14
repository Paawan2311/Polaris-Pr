variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region to deploy"
}

variable "name" {
  default     = "polaris"
  description = "Base name for all resources"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  default = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "azs" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cluster_name" {
  default = "polaris-eks"
}

variable "cluster_version" {
  default = "1.28"
}
