terraform {
  required_providers {
    aws = {
      version = ">5.5"
      source  = "hashicorp/aws"

    }
  }
}
provider "aws" {
  region = var.region
}