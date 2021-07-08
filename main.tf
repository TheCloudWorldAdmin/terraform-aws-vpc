################################################################################
# VPC
################################################################################

resource "aws_vpc" "myVPC" {
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = {
    Name = var.vpc_name
  
}
}
locals {
  another_cidr = var.another_cidr
}

resource "aws_vpc_ipv4_cidr_block_association" "vpc_ipv4_cidr_association" {
  count = var.another_cidr ? 1 : 0

  vpc_id = aws_vpc.myVPC.id

  cidr_block = var.secondary_cidr
}


################################################################################
# DHCP Options Set
################################################################################

#resource "aws_vpc_dhcp_options" "dhcp_options" {
#  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

#  domain_name          = var.dhcp_options_domain_name
#  domain_name_servers  = var.dhcp_options_domain_name_servers
#  ntp_servers          = var.dhcp_options_ntp_servers
#  netbios_name_servers = var.dhcp_options_netbios_name_servers
#  netbios_node_type    = var.dhcp_options_netbios_node_type

  #tags = {
  #  "Name" = var.dhcp_options_tag
#}
#}

#resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
#  count = var.create_vpc && var.enable_dhcp_options ? 1 : 0

  #vpc_id          = aws_vpc.myVPC.id
  #dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
#}

################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "myIGW" {

  vpc_id = aws_vpc.myVPC.id

  tags = {
    "Name" = var.igw_tag
}
}  

resource "aws_egress_only_internet_gateway" "my_egress_IGW" {
  count = var.create_vpc && var.create_egress_only_igw ? 1 : 0

  vpc_id = aws_vpc.myVPC.id

 tags = {
    "Name" = var.egress_igw_tag
}
} 


################################################################################
# Database subnet Group for RDS
################################################################################
data "aws_subnet_ids" "subnet_ids" {
  vpc_id = aws_vpc.myVPC.id
  
    filter {
    name   = "tag:Name"
    values = [var.database_subnet_tag] # insert values here
  }
}

data "aws_subnet" "subnet" {
  for_each = data.aws_subnet_ids.subnet_ids.ids
  id       = each.value
}

output "subnet_cidr_blocks" {
  value = [for s in data.aws_subnet.subnet : s.id]
}

resource "aws_db_subnet_group" "database_subnet_group" {
  
  subnet_ids  = [for s in local.db_group : s.id]
  name        = var.db_subnet_group_name
  description = "Database subnet group for ${var.db_subnet_group_name}"
  tags = {
    "Name" = var.db_subnet_group_name
  }
}

################################################################################
# Defaults
################################################################################

resource "aws_default_vpc" "default_vpc" {
  count = var.manage_default_vpc ? 1 : 0

  enable_dns_support   = var.default_vpc_enable_dns_support
  enable_dns_hostnames = var.default_vpc_enable_dns_hostnames
  enable_classiclink   = var.default_vpc_enable_classiclink

  tags = {
    "Name" = var.default_vpc_tag
}
}
