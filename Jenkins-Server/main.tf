locals {
  name = "jenkins-server"
}
# Create AWS VPC Module Terraform
module "vpc" {
  source                  = "terraform-aws-modules/vpc/aws"
  version                 = "5.13.0"
  name                    = "${local.name}-vpc"
  cidr                    = var.cidr
  azs                     = data.aws_availability_zones.azs.names
  public_subnets          = var.public_subnet_cidr
  enable_dns_hostnames    = true
  map_public_ip_on_launch = true
  tags = {
    Name    = "${local.name}-vpc"
    ENV     = "Devlopment"
    Profile = "devopsbasic"
  }
  public_subnet_tags = {
    Name    = "${local.name}-subnet"
    ENV     = "Devlopment"
    Profile = "devopsbasic"
  }

}

# Create AWS SG Module Terraform
module "sg" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${local.name}-SG"
  description = "${local.name}-SG for Port 22,80,8080,9000"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "Jenkins"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allowed All traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
    Name    = "${local.name}-SG"
    ENV     = "Devlopment"
    Profile = "devopsbasic"
  }
}


# Create  AWS EC2 Module Terraform
module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  name                        = "${local.name}-ec2"
  ami                         = data.aws_ami.name.id
  instance_type               = var.instance_type
  key_name                    = "cicd-project-tf"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file(("install.sh"))
  availability_zone           = data.aws_availability_zones.azs.names[0]
  root_block_device = [
    {
      volume_type           = var.ebs_volume[0].v_type
      volume_size           = var.ebs_volume[0].v_size
      delete_on_termination = true
    }
  ]
  tags = {
    Name    = "${local.name}-EC2"
    ENV     = "Devlopment"
    Profile = "devopsbasic"
  }

}

