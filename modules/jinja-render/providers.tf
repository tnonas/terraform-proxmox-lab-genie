terraform {
  required_providers {
    jinja = {
      source = "registry.terraform.io/NikolaLohinski/jinja"
      version = "2.4.2"
    }
    local = {
      source = "registry.terraform.io/hashicorp/local"
      version = "2.5.2"
    }
  }
}