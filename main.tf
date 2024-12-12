module "lab-genie" {
  source = "./modules/lab-genie"
  endpoint = var.endpoint
  node_name = var.node_name
  pools = var.pools
  virtual_machines = var.virtual_machines
  containers = var.containers
}