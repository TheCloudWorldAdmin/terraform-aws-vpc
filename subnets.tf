################################################################################
# Availability Zones list out
################################################################################
 data "aws_availability_zones" "available" {
  state = "available"
}
################################################################################
# Public subnet
################################################################################

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)
  vpc_id                          = aws_vpc.myVPC.id
  cidr_block                      = var.public_subnets_cidr[count.index]
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.public_subnet_assign_ipv6_address_on_creation

  #ipv6_cidr_block = var.ipv6_cidr_block_public[count.index]

  tags = {
    "Name" = var.public_subnet_tag
}
}
################################################################################
# Private subnet
################################################################################

resource "aws_subnet" "private" {
  count = length(var.private_subnets_cidr)

  vpc_id                          = aws_vpc.myVPC.id
  cidr_block                      = var.private_subnets_cidr[count.index]
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation
  map_public_ip_on_launch         = false
 # ipv6_cidr_block = var.ipv6_cidr_block_private[count.index]

  tags = {
    "Name" = var.private_subnet_tag
}
}

################################################################################
# Database subnet
################################################################################

resource "aws_subnet" "database" {
  count = length(var.database_subnets)
  vpc_id                          = aws_vpc.myVPC.id
  cidr_block                      = var.database_subnets[count.index]
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation
  map_public_ip_on_launch         = false
  #ipv6_cidr_block = var.ipv6_cidr_block_private[count.index]

  tags = {
    "Name" = var.database_subnet_tag
}
}
  
