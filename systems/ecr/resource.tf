module "ecr" {
  source = "../../modules/ecr"

  service_name = var.service_name
  env          = var.env
  role         = var.role
}
