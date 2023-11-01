terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20.0"
    }
    porkbun = {
      source = "cullenmcdermott/porkbun"
      version = "0.2.5"
    }
  }
  cloud {
    organization = "cloud-resume-challenge-jm"
    workspaces {
      name = "learn-tfc-aws"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

provider "porkbun" {
  api_key = local.apis.porkbun_api_key
  secret_key = local.apis.porkbun_secret_api_key
}
