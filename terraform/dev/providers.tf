terraform {
  required_version = "~>1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraform-tfstate-joadfkjeaofhjkdahf"
    key    = "dev/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  alias  = "ap1"
}