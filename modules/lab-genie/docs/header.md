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

- Create YAML configuration file specific to your lab topology and place it as _./data/config.yaml_
- Execute _jinja-render.py_ Python script to convert YAML configuration file into Terraform .tfvars variable definition file
- Use Terraform or OpenTofu to deploy and lifecycle your lab topology in Proxmox Virtual Environment (PVE)

## Example

- An example YAML configuration file (Jinja2 template context) is located in _./data/config.yaml_
- Jinja2 template itself is located in _./data/terraform.tfvars.j2_
- _jinja-render.auto.tfvars.example_ is an example .tfvars variable definition file created after executing _jinja-render.py_ Python module