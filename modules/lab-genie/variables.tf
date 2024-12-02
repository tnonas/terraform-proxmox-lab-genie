variable "endpoint" {
  description = "The address of Proxmox server API"
  type        = string
}

variable "node_name" {
  description = "Proxmox node hosting lab topology as named in PVE Datacenter"
  type        = string
}

variable "pool" {
  description = "Proxmox resource pool"
  type = string
  default = ""
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