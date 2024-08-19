terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">5.5"
    }
  }
}
provider "aws" {
  region = var.region
}