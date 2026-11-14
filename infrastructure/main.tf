terraform{
    required_version = ">= 1.5.0"
}

resource "terraform_data" "app"{
    input = {
        name        = "minha_aplicacao"
        environment  = "production"
        owner_team  = "platform"
        encrypted   = true
    }
}