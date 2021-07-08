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
  

################################################################################
# Database subnet Group for RDS
################################################################################
#data "aws_subnet_ids" "subnet_ids" {
#  vpc_id = aws_vpc.myVPC.id
#  
#    filter {
#    name   = "tag:Name"
#    values = [var.database_subnet_tag] # insert values here
#  }
#}

#data "aws_subnet" "subnet" {
#  for_each = data.aws_subnet_ids.subnet_ids.ids
#  id       = each.value
#}

#output "subnet_cidr_blocks" {
#  value = [for s in data.aws_subnet.subnet : s.id]
#}

#resource "aws_db_subnet_group" "database_subnet_group" {
  
#  subnet_ids  = [for s in data.aws_subnet.subnet : s.id]
# name        = var.db_subnet_group_name
#  description = "Database subnet group for ${var.db_subnet_group_name}"
#  tags = {
#    "Name" = var.db_subnet_group_name
#  }
#}

