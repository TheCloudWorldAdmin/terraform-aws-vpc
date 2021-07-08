################################################################################
# Default route
################################################################################
# locals {
#  default_route_table_routes = [{
#    cidr_block = var.cidr_block_default_route_table
#    ipv6_cidr_block = var.ipv6_cidr_block_route
#    egress_only_gateway_id = var.egress_only_gateway_id_route
#    gateway_id = var.gateway_id_route
#    instance_id = var.instance_id_route
#    nat_gateway_id = var.nat_gateway_id_route
#    network_interface_id = var.network_interface_id_route
#    transit_gateway_id = var.transit_gateway_id_route
#    vpc_endpoint_id = var.vpc_endpoint_id_route
#    vpc_peering_connection_id = var.vpc_peering_connection_id_route
#  }]
#  }  
#resource "aws_default_route_table" "default_route_table" {
 # count = var.create_vpc && var.manage_default_route_table ? 1 : 0

#  default_route_table_id = aws_vpc.myVPC.default_route_table_id
  #propagating_vgws       = var.default_route_table_propagating_vgws

#  dynamic "route" {
#    for_each = var.default_route_table_routes
#    content {
#      # One of the following destinations must be provided
#      cidr_block      = route.value.cidr_block
#      ipv6_cidr_block = lookup(route.value, "ipv6_cidr_block", null)

#      # One of the following targets must be provided
#      egress_only_gateway_id    = lookup(route.value, "egress_only_gateway_id", null)
#      gateway_id                = lookup(route.value, "gateway_id", null)
#      instance_id               = lookup(route.value, "instance_id", null)
#      nat_gateway_id            = lookup(route.value, "nat_gateway_id", null)
#      network_interface_id      = lookup(route.value, "network_interface_id", null)
#      transit_gateway_id        = lookup(route.value, "transit_gateway_id", null)
#      vpc_endpoint_id           = lookup(route.value, "vpc_endpoint_id", null)
#      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
#    }
#  }

#  tags = {
#    "Name" = var.default_route_table_tag
#}
#}

################################################################################
# Publiс routes
################################################################################

resource "aws_route_table" "public_route_table" {
  count = var.create_vpc ? 1 : 0

  vpc_id = aws_vpc.myVPC.id

  tags = {
    "Name" = var.public_route_table_tag
}
}
resource "aws_route" "public_internet_gateway" {
  count = var.create_vpc && var.create_igw ? 1 : 0

  route_table_id         = aws_route_table.public_route_table[count.index]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myIGW[count.index]

  timeouts {
    create = "10m"
  }
}

resource "aws_route" "public_internet_gateway_ipv6" {
  count = var.create_vpc && var.create_igw ? 1 : 0

  route_table_id              = aws_route_table.public_route_table[count.index]
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.myIGW[count.index]
}

################################################################################
# Private routes
# There are as many routing tables as the number of NAT gateways
################################################################################

resource "aws_route_table" "private" {
  count = var.create_vpc ? var.nat_gateway_count : 0

  vpc_id = aws_vpc.myVPC.id

  tags = {
    "Name" = var.private_route_table_tag
}
}
################################################################################
# Database routes
################################################################################

resource "aws_route_table" "database" {
  count = var.create_vpc ? 1 : 0

  vpc_id = aws_vpc.myVPC.id

  tags = {
    "Name" = var.database_route_table_tag
  }
}

resource "aws_route" "database_internet_gateway" {
  count = var.create_vpc && var.create_igw ? 1 : 0

  route_table_id         = aws_route_table.database[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myIGW.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "database_nat_gateway" {
  count = var.create_vpc ? 1 : 0
  
  route_table_id         = element(aws_route_table.database.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.my_nat.*.id, count.index)

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "database_ipv6_egress" {
  count = var.create_vpc && var.create_egress_only_igw ? 1 : 0

  route_table_id              = aws_route_table.database[0].id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.my_egress_IGW[0].id

  timeouts {
    create = "5m"
  }
}






################################################################################
# Route table association
################################################################################

resource "aws_route_table_association" "private_route_table_association" {
  count = var.create_vpc && var.private_route_table_association_required ? 1: 0

  subnet_id = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.*.id
}


resource "aws_route_table_association" "database" {
 count = var.create_vpc && var.database_route_table_association_required ? 1: 0

  subnet_id = element(aws_subnet.database.*.id, count.index)
  route_table_id = aws_route_table.database.*.id
}


resource "aws_route_table_association" "public" {
  count = var.create_vpc && var.public_route_table_association_required ? 1: 0
  
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_route_table[count.index]
}
