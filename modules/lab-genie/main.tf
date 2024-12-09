# Create PVE pools
## Get IDs of the existing pools and create new pools if not existent
data "proxmox_virtual_environment_pools" "existing_pools" {}
## Record all existing pool IDs as local variable
locals {
  existing_pools = data.proxmox_virtual_environment_pools.existing_pools.pool_ids
}
# Create pool ID which do not exist
# resource "proxmox_virtual_environment_pool" "this" {
#   # Loop over var.virtual_machines entries containing only pool ID which is not part of existing pool IDs
#   for_each = {for k, v in var.virtual_machines : k => v if contains(local.existing_pools, v.pool_id) == false}
#   pool_id = each.value.pool_id
# }
resource "proxmox_virtual_environment_pool" "this" {
  # Loop over var.virtual_machines entries containing only pool ID which is not part of existing pool IDs
  for_each = {for k, v in var.pools : k => v if contains(local.existing_pools, v.name) == false}
  pool_id = each.value.name
}

# Generate VMs
resource "proxmox_virtual_environment_vm" "this" {
  depends_on = [proxmox_virtual_environment_pool.this]
  for_each  = var.virtual_machines
  node_name = var.node_name
  # Provide clone source template or VM details
  clone {
    vm_id = each.value.clone.vm_id
    full  = each.value.clone.full # Controls whether to do full or linked clone
  }
  # Configure resulting VM details
  name            = each.value.name
  vm_id           = each.value.vm_id
  started         = each.value.started
  on_boot         = each.value.on_boot
  stop_on_destroy = each.value.stop_on_destroy # Whether to stop instead of shutdown during tf destroy
  pool_id         = each.value.pool_id         # Pool / group ID
  tags            = each.value.tags            # Tags applied to the new VM. Will override the template's tags.
  # hook_script_file_id   = "" # Hookscript filename
  # Configure VM's network interface. The below settings will override the template's settings.
  # Each entry's network_devices attribute in var.virtual_machines will be parsed yielding several network_device resource blocks
  dynamic "network_device" {
    for_each = var.virtual_machines[each.key].network_devices
    content {
      bridge       = network_device.value.bridge
      disconnected = network_device.value.disconnected
      vlan_id      = network_device.value.vlan_id
    }
  }
}