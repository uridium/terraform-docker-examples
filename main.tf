module "image" {
  for_each = local.services

  source = "./image"

  image_in = each.value["image"]
}

module "container" {
  for_each = local.services

  source = "./container"

  count_in    = each.value["container_count"]
  name_in     = each.key
  image_in    = module.image[each.key].image_out
  int_port_in = each.value["int"]
  ext_port_in = each.value["ext"]
  volumes_in  = each.value["volumes"]
}
