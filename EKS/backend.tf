terraform {
  backend "s3" {
    bucket = "tf-nginx-eks-app"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"

  }
}