terraform {
  backend "s3" {
    bucket = "tf-nginx-eks-app"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}