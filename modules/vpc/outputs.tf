output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = aws_vpc.vpc.tags["Name"]
}

output "public_subnets" {
  description = "パブリックサブネットの情報です"
  value       = { for subnet in aws_subnet.public_subnets : subnet.availability_zone => subnet.id }
}

output "private_subnets" {
  description = "プライベートサブネットの情報です"
  value       = { for subnet in aws_subnet.private_subnets : subnet.availability_zone => subnet.id }
}

output "public_route_tables" {
  description = "パブリックルートテーブルの情報です"
  value       = { for rt in aws_route_table.public_route_tables : rt.tags["AvailabilityZone"] => rt.id }
}

output "private_route_tables" {
  description = "プライベートルートテーブルの情報です"
  value       = { for rt in aws_route_table.private_route_tables : rt.tags["AvailabilityZone"] => rt.id }
}
