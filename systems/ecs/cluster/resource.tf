module "cluster" {
  source = "../../../modules/ecs/cluster"

  service_name = var.service_name
  env          = var.env

  cluster_additional_tags = {
    Usage = "Sample ecs cluster explanation"
  }
}
