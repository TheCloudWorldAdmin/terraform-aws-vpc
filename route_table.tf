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
