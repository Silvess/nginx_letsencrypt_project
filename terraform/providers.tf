terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    local = {
      source = "hashicorp/local"
      version = "2.3.0"
    }

    aws = {
      source = "hashicorp/aws"
      version = "4.56.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
}
}

provider "digitalocean" {
  token = var.do_token
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}