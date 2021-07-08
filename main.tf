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
