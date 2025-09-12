output "vpc_id" {
  value       = module.vpc.vpc_id
}

output "vpc_name" {
  value       = module.vpc.vpc_name
}

output "public_subnets" {
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  value       = module.vpc.private_subnets
}

output "public_route_tables" {
  value       = module.vpc.public_route_tables
}

output "private_route_tables" {
  value       = module.vpc.private_route_tables
}
