locals {
  service_name = "sample"
  env          = "dev"

  dns_hosted_zone_domain = "jnytnai.click."
  dns_a_record           = "terraform-sample.jnytnai.click."
  certificate_domain     = "terraform-sample.jnytnai.click"
}
