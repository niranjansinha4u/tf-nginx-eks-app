locals {
  name     = "eks-server"
  eks_name = "my-eks-cluster"
}

# VPC
module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = "${local.name}-vpc"
  cidr                 = var.cidr
  azs                  = data.aws_availability_zones.azs.names
  private_subnets      = var.private_subnet_cidr
  public_subnets       = var.public_subnet_cidr
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernates.io/cluster/${local.eks_name}" = "shared"
  }
  public_subnet_tags = {
    "kubernates.io/cluster/${local.eks_name}" = "shared"
    "kubernates.io/role/elb"                  = 1
  }
  private_subnet_tags = {
    "kubernates.io/cluster/${local.eks_name}" = "shared"
    "kubernates.io/role/internal-elb"         = 1
  }
}
# EKS
module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  cluster_name                   = local.eks_name
  cluster_version                = "1.29"
  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size      = 1
      max_size      = 3
      desired_size  = 2
      instance_type = ["t2-micro"]
    }
    tags = {
      Name      = "${local.name}-EKS"
      ENV       = "Devlopment"
      Profile   = "devopsbasic"
      Terraform = true
    }
  }
}