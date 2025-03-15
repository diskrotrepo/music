terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.19.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile
}
