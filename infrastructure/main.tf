terraform {
  required_version = ">= 1.5.0"
  backend "local" {
    path = "/terraform-state/terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "terraform_data" "app" {
  input = {
    name        = "minha_aplicacao"
    environment = "production"
    owner_team  = "platform"
    encrypted   = true
    version     = "1.0.2"
  }
}
