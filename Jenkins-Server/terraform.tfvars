region = "us-east-1"

cidr = "10.0.0.0/16"

public_subnet_cidr = ["10.0.0.0/24"]

instance_type = "t2.medium"

ebs_volume = [{
  v_type = "gp3"
  v_size = 30
}]