terraform {
  required_providers {
    proxmox = {
      source  = "registry.terraform.io/bpg/proxmox"
      version = "0.68.0"
    }
    jinja = {
      source = "NikolaLohinski/jinja"
      version = "2.4.2"
    }
  }
}

provider "proxmox" {
  endpoint = var.endpoint
  insecure = true # Disable TLS verification
  # api_token = "" # Not used explicitly here, taken from PROXMOX_VE_API_TOKEN environment variable. Must have "TokenID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" format.
  # username = "" # Not used explicitly here, taken from PROXMOX_VE_USERNAME environment variable.
  # password = "" # Not used explicitly here, taken from PROXMOX_VE_PASSWORD environment variable.
  # ssh {
  #   agent       = false
  #   # username = "" # Not used explicitly here, taken from PROXMOX_VE_SSH_USERNAME environment variable.
  #   # private_key = file("~/.ssh/id_rsa") # Not used explicitly here, taken from PROXMOX_VE_SSH_PRIVATE_KEY environment variable.
  # }
}

provider "jinja" {
  delimiters {
    variable_start = "{{"
    variable_end   = "}}"
    block_start    = "{%"
    block_end      = "%}"
    comment_start  = "{#"
    comment_end    = "#}"
  }
  strict_undefined  = false
  left_strip_blocks = false
  trim_blocks       = false
}