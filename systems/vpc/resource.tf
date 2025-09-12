module "vpc" {
  source = "../../modules/vpc"

  service_name = var.service_name
  env          = var.env

  # variables for vpc resource
  vpc_cidr_block = var.vpc_cidr_block

  vpc_additional_tags = {
    Usage = "Sample vpc explanation"
  }

  # variables for subnet resource
  subnet_cidrs = {
    public  = [cidrsubnet(var.vpc_cidr_block, 6, 0), cidrsubnet(var.vpc_cidr_block, 6, 1), cidrsubnet(var.vpc_cidr_block, 6, 2)]
    private = [cidrsubnet(var.vpc_cidr_block, 6, 3), cidrsubnet(var.vpc_cidr_block, 6, 4), cidrsubnet(var.vpc_cidr_block, 6, 5)]
  }

  subnet_additional_tags = {
    Usage = "Sample subnet explanation"
  }

  # variables for internet gateway resource
  igw_additional_tags = {
    Usage = "Sample igw explanation"
  }
}
