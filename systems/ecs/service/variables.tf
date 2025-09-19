locals {
  service_name = "sample"
  env          = "dev"

  ecs_cluster_name = "${local.service_name}-${local.env}-cluster"
  ecs_task_family  = "${local.service_name}-${local.env}-task"


  dns_hosted_zone_domain = "jnytnai.click."
  dns_a_record           = "terraform-sample.jnytnai.click."
  certificate_domain     = "terraform-sample.jnytnai.click"
}
