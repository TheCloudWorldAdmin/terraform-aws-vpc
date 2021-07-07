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

#################################################################################
# Default security group
################################################################################
#+
#locals {
#  default_security_group_ingress = {
#    description = "Ingress default security group"
#    from_port = var.ingress_from_port
#    to_port = var.ingress_to_port
#    protocol = var.ingress_protocol
#    ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
#    prefix_list_ids = var.ingress_prefix_list_ids
#    security_groups = var.ingress_security_groups
#}
#  
#}
#locals {
#  default_security_group_egress = {  
#    description = "Egress default security group"
#    from_port = var.egress_from_port
#    to_port = var.egress_to_port
#    protocol = var.egress_protocol
#    ipv6_cidr_blocks = var.egress_ipv6_cidr_blocks
#    prefix_list_ids = var.egress_prefix_list_ids
#    security_groups = var.egress_security_groups
#}
#}

#resource "aws_default_security_group" "this" {
#  count = var.create_vpc && var.manage_default_security_group ? 1 : 0

  #vpc_id = aws_vpc.myVPC.id

#  dynamic "ingress" {
#    for_each = var.default_security_group_ingress
#    content {
#      self             = lookup(ingress.value, "self", null)
#      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
#      ipv6_cidr_blocks = lookup(ingress.value, "ingress_ipv6_cidr_blocks", null)
#      prefix_list_ids  = lookup(ingress.value, "prefix_list_ids", null)
 #     security_groups  = lookup(ingress.value, "security_groups", null)
 #     description      = lookup(ingress.value, "description", null)
 #     from_port        = lookup(ingress.value, "from_port", 0)
 #     to_port          = lookup(ingress.value, "to_port", 0)
 #     protocol         = lookup(ingress.value, "protocol", "-1")
 #   }
 # }

#  dynamic "egress" {
#    for_each = var.default_security_group_egress
#    content {
#      self             = lookup(egress.value, "self", null)
#      cidr_blocks      = lookup(egress.value, "cidr_blocks", null)
#      ipv6_cidr_blocks = lookup(egress.value, "ingress_ipv6_cidr_blocks", null)
#      prefix_list_ids  = lookup(egress.value, "prefix_list_ids", null)
#      security_groups  = lookup(egress.value, "security_groups", null)
#      description      = lookup(egress.value, "description", null)
#      from_port        = lookup(egress.value, "from_port", 0)
#      to_port          = lookup(egress.value, "to_port", 0)
#      protocol         = lookup(egress.value, "protocol", "-1")
  #  }
  #}

#  tags = {
#    "Name" = var.default_security_group_name
#}
#}

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
  count = var.create_vpc && var.create_igw ? 1 : 0

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

##################################################################################
# NAT Gateway Private
################################################################################
resource "aws_eip" "nat_eip" {
  vpc = true

  tags = {
    "Name" = var.nat_gateway_tag
}
}
resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.database[count.index]
  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.myIGW]
}



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
  gateway_id             = aws_internet_gateway.myIGW[0].id

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
# Availability Zones list out
################################################################################
 data "aws_availability_zones" "available" {
  state = "available"
}
################################################################################
# Public subnet
################################################################################

resource "aws_subnet" "public" {
  count = var.create_vpc ? var.public_subnet_count : 0
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
  count = var.create_vpc && var.private_subnet_count ? 1 : 0

  vpc_id                          = aws_vpc.myVPC.id
  cidr_block                      = var.private_subnets_cidr[count.index]
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation

 # ipv6_cidr_block = var.ipv6_cidr_block_private[count.index]

  tags = {
    "Name" = var.private_subnet_tag
}
}

################################################################################
# Database subnet
################################################################################

resource "aws_subnet" "database" {
  count = var.create_vpc ? 2 : 0

  vpc_id                          = aws_vpc.myVPC.id
  cidr_block                      = var.database_subnets
  availability_zone               = data.aws_availability_zones.available.names[count.index]
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation

  #ipv6_cidr_block = var.ipv6_cidr_block_private[count.index]

  tags = {
    "Name" = var.database_subnet_tag
}
}
  
################################################################################
# Database subnet Group for RDS
################################################################################

resource "aws_db_subnet_group" "database_subnet_group" {
  count = var.database_subnets_count > 0 ? 1 : 0

  name        = var.db_subnet_group_name
  description = "Database subnet group for ${var.db_subnet_group_name}"
  subnet_ids  = aws_subnet.database.*.id

  tags = {
    "Name" = var.db_subnet_group_name
  }
}


################################################################################
# Default Network ACLs
################################################################################

resource "aws_default_network_acl" "my_default_network_acl" {
  count = var.create_vpc && var.manage_default_network_acl ? 1 : 0

  default_network_acl_id = aws_vpc.myVPC.default_network_acl_id
}
################################################################################
# Public Network ACLs
################################################################################

  
resource "aws_network_acl" "public_network_acl" {
  count = var.create_vpc && var.public_dedicated_network_acl ? 1 : 0

  vpc_id     = aws_vpc.myVPC.id
  subnet_ids = aws_subnet.public.*.id

  tags = {
    "Name" = var.public_network_acl_tag
}
}

resource "aws_network_acl_rule" "public_inbound" {
  count = var.create_vpc && var.public_dedicated_network_acl ? 1 : 0

  network_acl_id = aws_network_acl.public_network_acl[count.index]

  egress          = false
  rule_number     = var.public_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.public_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.public_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.public_inbound_acl_rules[count.index], "to_port", null)
  protocol        = var.public_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.public_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.public_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "public_outbound" {
  count = var.create_vpc && var.public_dedicated_network_acl ? 1 : 0

  network_acl_id = aws_network_acl.public_network_acl[count.index]

  egress          = true
  rule_number     = var.public_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.public_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.public_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.public_outbound_acl_rules[count.index], "to_port", null)
  protocol        = var.public_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.public_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.public_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

################################################################################
# Private Network ACLs
################################################################################

resource "aws_network_acl" "private" {
  count = var.create_vpc && var.private_dedicated_network_acl ? 1 : 0

  vpc_id     = aws_vpc.myVPC.id
  subnet_ids = aws_subnet.private.*.id

  tags = {
    "Name" = var.private_subnet_name
}
}
resource "aws_network_acl_rule" "private_inbound" {
  count = var.create_vpc && var.private_dedicated_network_acl ? 1 : 0

  network_acl_id = aws_network_acl.private[count.index]

  egress          = false
  rule_number     = var.private_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.private_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.private_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.private_inbound_acl_rules[count.index], "to_port", null)
  protocol        = var.private_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.private_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.private_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "private_outbound" {
  count = var.create_vpc && var.private_dedicated_network_acl ? 1 : 0

  network_acl_id = aws_network_acl.private[count.index]

  egress          = true
  rule_number     = var.private_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.private_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.private_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.private_outbound_acl_rules[count.index], "to_port", null)
  protocol        = var.private_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.private_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.private_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
}


################################################################################
# Database Network ACLs
################################################################################

resource "aws_network_acl" "database" {
  count = var.create_vpc && var.database_dedicated_network_acl ? 1 : 0

  vpc_id     = aws_vpc.myVPC.id
  subnet_ids = aws_subnet.database.*.id

  tags = {
    "Name" = var.nacl_database_tag
}
}
resource "aws_network_acl_rule" "database_inbound" {
  count = var.create_vpc && var.database_dedicated_network_acl ? 1 : 0

  network_acl_id = aws_network_acl.database[count.index]

  egress          = false
  rule_number     = var.database_inbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.database_inbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.database_inbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.database_inbound_acl_rules[count.index], "to_port", null)
  protocol        = var.database_inbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.database_inbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.database_inbound_acl_rules[count.index], "ipv6_cidr_block", null)
}

resource "aws_network_acl_rule" "database_outbound" {
  count = var.create_vpc && var.database_dedicated_network_acl ? 1 : 0

  network_acl_id = aws_network_acl.database[count.index]

  egress          = true
  rule_number     = var.database_outbound_acl_rules[count.index]["rule_number"]
  rule_action     = var.database_outbound_acl_rules[count.index]["rule_action"]
  from_port       = lookup(var.database_outbound_acl_rules[count.index], "from_port", null)
  to_port         = lookup(var.database_outbound_acl_rules[count.index], "to_port", null)
  protocol        = var.database_outbound_acl_rules[count.index]["protocol"]
  cidr_block      = lookup(var.database_outbound_acl_rules[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(var.database_outbound_acl_rules[count.index], "ipv6_cidr_block", null)
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
