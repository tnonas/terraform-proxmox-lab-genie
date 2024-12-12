# ---------------------------------------------------------------------------
# Generate tfvars file from jinja template and variables context as YAML file
# ---------------------------------------------------------------------------
data "jinja_template" "render" {
  context {
    type = "yaml"
    data = file("${path.module}/../../data/config.yaml")
  }
  source {
    template  = file("${path.module}/../../data/terraform.tfvars.j2")
    directory = "${path.module}/../../data"
  }
}

resource "local_file" "jinja_render_result" {
  content  = data.jinja_template.render.result
  filename = "jinja_rendered.auto.tfvars"
}