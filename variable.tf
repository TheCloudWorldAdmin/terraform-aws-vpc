variable "create_vpc" {
  description = "Whether the VPC is getting created"
  type = bool
  default = false
}

variable "cidr" {
  description = "Enter the CIDR range required for VPC"
  type = string
  default = "10.0.0.0/16"
}
variable "instance_tenancy" {
  description = "Instance will be shared, dedicated and host. 'default' is shared"
  type = string
  default = "default"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS Hostname"
  type = bool
  default = false
}

variable "enable_dns_support" {
  description = "Enable DNS Support"
  type = bool
  default = false
}

variable "enable_classiclink" {
  description = "A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type = bool
  default = false
}

variable "enable_classiclink_dns_support" {
  description = "A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type = bool
  default = false
}

variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
  type = bool
  default = false
}

variable "vpc_name" {
  description = "Tag Name to be assigned with VPC"
  type = string
  default = "myVPC"
}

variable "another_cidr" {
  description = "Whether another CIDR is required"
  type = bool
  default = false
}

variable "secondary_cidr" {
  description = "Enter the CIDR range for secondary CIDR Block"
  type = string
  default = "192.168.0.0/16"
}
variable "default_security_group_name" {
  description = "Enter the name for security group"
  type = string
  default = "my_default_security_group"
}

variable "enable_dhcp_options" {
  description = "Enable DHCP options.. True or False"
  type = bool
  default = false
}

variable "manage_default_route_table" {
  description = "Are we managing default route table"
  type = bool
  default = false
}

#variable "default_route_table_propagating_vgws" {
#  description = "List of virtual gateways"
#  type = list(string)
#  default = ["",""]
#}

variable "enable_nat_gateway" {
  description = "Whether to enable NAT Gateway"
  type = bool
  default = true
}

variable "nat_gateway_count" {
  description = "Number of NAT Gateway"
  type = number
  default = 1
}

variable "nat_gateway_tag" {
  description = "Enter the Tag name of NAT Gateway"
  type = string
  default = "my_natgateway"
}
variable "public_subnet" {
  description = "enter the number of public subnets you need"
  type = number
  default = 1
}

variable "public_subnet_count" {
  description = "Enter the number public subnets you want"
  type = number
  default = 1
}

variable "public_subnets_cidr" {
  description = "Cidr Blocks"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type = bool
  default = true
}

variable "public_subnet_assign_ipv6_address_on_creation" {
  description = "IPv6 address to be assinged to resources"
  type = bool
  default = false
}

#variable "ipv6_cidr_block_public" {
#  description = "IPv6 cidr block to be used"
#  type = list(string)
#  default = {""}
#}

variable "private_subnet_assign_ipv6_address_on_creation" {
  description = "IPv6 address to be assinged to resources"
  type = bool
  default = false
}

#ariable "ipv6_cidr_block_private" {
# description = "IPv6 cidr block to be used"
# type = list(string)
# default = {""}
#
variable "database_subnets_count" {
  description = "Enter the number of subnets required for DB"
  type = number
  default = 2
}

variable "db_subnet_group_name" {
  description = "Name of the subnet group created"
  type = string
  default = "my_subnet_group"
}

variable "manage_default_network_acl" {
  description = "Specify whether default network ACL is required"
  type = bool
  default = true
}

variable "public_dedicated_network_acl" {
  description = "Whether public dedicated NACL is required"
  type = bool
  default = true
}

variable "public_network_acl_tag" {
  description = "Tag for the public network acl"
  type = string
  default = "My public NACL"
}

variable "public_inbound_acl_rules" {
  description = "Public subnets inbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "public_outbound_acl_rules" {
  description = "Public subnets outbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "private_inbound_acl_rules" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "private_outbound_acl_rules" {
  description = "Private subnets outbound network ACLs"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "database_inbound_acl_rules" {
  description = "Database subnets inbound network ACL rules"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "database_outbound_acl_rules" {
  description = "Database subnets outbound network ACL rules"
  type        = list(map(string))

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "private_route_table_association_required" {
  description = "Whether private route table association is required"
  type = bool
  default = true
}
variable "manage_default_vpc" {
  description = "Whether default VPC is required"
  type = bool
  default = false
}
