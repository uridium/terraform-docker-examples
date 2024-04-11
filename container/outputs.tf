output "container_access" {
  value = { for i in docker_container.app_container[*] : i.name => join(":", i.network_data[*]["ip_address"], i.ports[*]["external"]) }
}
