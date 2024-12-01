resource "proxmox_virtual_environment_vm" "this" {
  for_each                = var.virtual_machines
  node_name               = var.node_name

  clone {
    vm_id       = each.value.clone.vm_id
    full        = each.value.clone.full
  }

  name                    = each.value.name
  vm_id                   = each.value.vm_id
  started                 = each.value.started
  on_boot                 = each.value.on_boot
  stop_on_destroy         = each.value.stop_on_destroy # Whether to stop instead of shutdown during tf destroy
  pool_id                 = each.value.pool_id
  tags                    = each.value.tags
  # hook_script_file_id   = "" # Hookscript filename

  network_device {
    bridge          = each.value.network_device.bridge
    disconnected    = each.value.network_device.disconnected
  }
  network_device {
    bridge          = each.value.network_device.bridge
    disconnected    = each.value.network_device.disconnected
    vlan_id         = each.value.network_device.vlan_id
  }

}