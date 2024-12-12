#!/usr/bin/env python3

# Takes terraform.tfvars.j2 template and config.yaml configuration context and creates jinja-render.auto.tfvars file to use with terraform modules

import jinja2, yaml


templateLoader = jinja2.FileSystemLoader(searchpath="./data")  # Define search path for template file location
templateEnv = jinja2.Environment(loader=templateLoader)  # Add the template path to template environment
TEMPLATE_FILE = "terraform.tfvars.j2"  # Define the actual template file
template = templateEnv.get_template(TEMPLATE_FILE) # Load template file

with open('./data/config.yaml') as f: # Load configuration file as render context
    context = yaml.safe_load(f)

outputText = template.render(context)  # Render template based on the context provided

with open('jinja-render.auto.tfvars', 'w') as f:
    f.write(outputText)