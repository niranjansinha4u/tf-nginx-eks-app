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

# public_subnet_cidr
variable "public_subnet_cidr" {
  type = list(string)
}

#EC2 Type
variable "instance_type" {
  type        = string
  description = "Instance Type"
}
# ebs_volume
variable "ebs_volume" {
  description = "ebs_volume Name and Type"
  type = list(object({
    v_type = string
    v_size = number
  }))
}