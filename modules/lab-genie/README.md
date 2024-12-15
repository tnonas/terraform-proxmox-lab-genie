<!-- BEGIN_TF_DOCS -->
# Proxmox Lab Genie
## Description

The module helps to rapidly spin up new lab topologies in Proxmox. A simple lab configuration is used in a form of YAML file. It defines all compute components (VMs and containers) alongside their networking configurations (IP addressing, bridges, VLANs, interconnections between VMs and containers). There is a single manual step to convert YAML lab definition to .tfvars variables definition format for Terraform consumption. Python module and Jinja2 templating logic is used for this. Once .tfvars file is generated, Terraform is used to deploy and lifecycle your lab topology on Proxmox Virtual Environment (PVE).

## Requirements

The module requires both Python and Terraform execution environments to be installed.
- Python script detailed requirements are defined in _requirements.txt_ file. In general, Jinja2 templating modules and YAML parsing modules are required.
- Terraform module uses _/bpg/proxmox_ provider hence the following requirements must be met
  - URL or IP address of a PVE hosting lab topologies
  - PVE API access token or username/password having required rights to deploy and lifecycle lab environments
  - A specific PVE node name hosting your labs
  - VMs are deployed based on the existing VM templates
  - Containers are created based on locally available (downloaded) PVE container templates

## Restrictions

- The current module revision requires PVE/Linux bridges to exist before they can be used in your lab definitions, i.e., bridges must be created outside of this module operations.

## Workflow

- Create YAML configuration file specific to your lab topology and place it as \_./data/config.yaml\_
- Execute _jinja-render.py_ Python script to convert YAML configuration file into Terraform .tfvars variable definition file
- Use Terraform or OpenTofu to deploy and lifecycle your lab topology in Proxmox Virtual Environment (PVE)

## Example

- An example YAML configuration file (Jinja2 template context) is located in \_./data/config.yaml\_
- Jinja2 template itself is located in \_./data/terraform.tfvars.j2\_
- _jinja-render.auto.tfvars.example\_ is an example .tfvars variable definition file created after executing \_jinja-render.py_ Python module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.68.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.68.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| proxmox_virtual_environment_container.this | resource |
| proxmox_virtual_environment_pool.this | resource |
| proxmox_virtual_environment_vm.this | resource |
| proxmox_virtual_environment_pools.existing_pools | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_containers"></a> [containers](#input\_containers) | Containers created based on downloaded CT templates | <pre>map(object({<br/>    vm_id           = number<br/>    started         = bool<br/>    start_on_boot = bool<br/>    pool_id         = string<br/>    tags            = list(string)<br/>    # hook_script_file_id = string<br/>    network_interfaces = map(object({<br/>      name         = string<br/>      bridge       = string<br/>      vlan_id      = number<br/>      enabled      = bool<br/>    }))<br/>    template_file_id = string<br/>    type = string<br/>    datastore_id = string<br/>    hostname        = string<br/>    password        = string<br/>    ip_configs       = map(object({<br/>      ipv4          = object({<br/>        address = string<br/>        gateway = optional(string)<br/>      })<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | The address of Proxmox server API | `string` | n/a | yes |
| <a name="input_node_name"></a> [node\_name](#input\_node\_name) | Proxmox node hosting lab topology as named in PVE Datacenter | `string` | n/a | yes |
| <a name="input_pools"></a> [pools](#input\_pools) | Proxmox resource pools | <pre>map(object({<br/>    name = string<br/>  }))</pre> | n/a | yes |
| <a name="input_virtual_machines"></a> [virtual\_machines](#input\_virtual\_machines) | VMs created based on prepared templates | <pre>map(object({<br/>    name            = string<br/>    vm_id           = number<br/>    started         = bool<br/>    on_boot         = bool<br/>    stop_on_destroy = bool<br/>    pool_id         = string<br/>    tags            = list(string)<br/>    # hook_script_file_id = string<br/>    clone = object({<br/>      vm_id = number<br/>      full  = bool<br/>    })<br/>    network_devices = map(object({<br/>      bridge       = string<br/>      disconnected = bool<br/>      vlan_id      = number<br/>    }))<br/>  }))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->    