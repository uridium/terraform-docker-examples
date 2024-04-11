resource "random_string" "random" {
  count = var.count_in

  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "app_container" {
  count = var.count_in

  name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}"
  image = var.image_in

  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }

  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["vol"]
      volume_name    = module.volume[count.index].volume_output[volumes.key]
    }
  }

  provisioner "local-exec" {
    when    = create
    command = "echo ${self.name}: ${self.network_data[0]["ip_address"]}:${join("", self.ports[*]["external"])} >>data.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -fv data.txt"
  }
}

module "volume" {
  count = var.count_in

  source = "../volume"

  volume_count = length(var.volumes_in)
  volume_name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}"
}
