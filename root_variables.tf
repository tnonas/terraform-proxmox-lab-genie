variable "endpoint" {
  description = "The address of Proxmox server API"
  type        = string
}

variable "node_name" {
  description = "Proxmox node hosting lab topology as named in PVE Datacenter"
  type        = string
}

variable "pools" {
  description = "Proxmox resource pools"
  type = map(object({
    name = string
  }))
}

variable "virtual_machines" {
  description = "VMs created based on prepared templates"
  type = map(object({
    name            = string
    vm_id           = number
    started         = bool
    on_boot         = bool
    stop_on_destroy = bool
    pool_id         = string
    tags            = list(string)
    # hook_script_file_id = string
    clone = object({
      vm_id = number
      full  = bool
    })
    network_devices = map(object({
      bridge       = string
      disconnected = bool
      vlan_id      = number
    }))
  }))
}

variable "containers" {
  description = "Containers created based on downloaded CT templates"
  type = map(object({
    vm_id           = number
    started         = bool
    start_on_boot = bool
    pool_id         = string
    tags            = list(string)
    # hook_script_file_id = string
    network_interfaces = map(object({
      name         = string
      bridge       = string
      vlan_id      = number
      enabled      = bool
    }))
    template_file_id = string
    type = string
    datastore_id = string
    hostname        = string
    password        = string
    ip_configs       = map(object({
      ipv4          = object({
        address = string
        gateway = optional(string)
      })
    }))
  }))
}