locals {
  from_az_to_public_subnet_id = { for cidr in keys(aws_subnet.public_subnets) :
  aws_subnet.public_subnets[cidr].tags["AvailabilityZone"] => aws_subnet.public_subnets[cidr].id }
}

resource "aws_eip" "eips" {
  for_each = local.from_az_to_public_subnet_id

  tags = {
    Name  = "${var.service_name}-${var.env}-${each.key}-eip"
    Env   = var.env
    Usage = "NAT Gateway EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  for_each = local.from_az_to_public_subnet_id

  allocation_id = aws_eip.eips[each.key].id
  subnet_id     = local.from_az_to_public_subnet_id[each.key]

  tags = {
    Name             = "${var.service_name}-${var.env}-${each.key}-nat-gateway"
    AvailabilityZone = each.key
  }
}
