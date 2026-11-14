# Comentário
terraform {
  required_version = ">= 1.5.0"
  backend "local" {
    path = "/terraform-state/terraform.tfstate"
  }
}

resource "terraform_data" "app" {
  input = {
    name        = "minha_aplicacao"
    environment = "production"
    owner_team  = "platform"
    encrypted   = true
    version     = "1.0.1"
  }
}
