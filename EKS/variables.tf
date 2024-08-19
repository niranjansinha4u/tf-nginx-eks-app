# Region
variable "region" {
  type        = string
  description = "Public Region Range"
}

#Public CIDR
variable "cidr" {
  type        = string
  description = "Public CIDR Range"
}

# public_subnets_cidr
variable "public_subnet_cidr" {
  type        = list(string)
  description = "public_subnets_cidr"
}

# private_subnets_cidr
variable "private_subnet_cidr" {
  type        = list(string)
  description = "private_subnets_cidr"
}

#EC2 Type
variable "instance_type" {
  type        = string
  description = "Instance Type"
}
