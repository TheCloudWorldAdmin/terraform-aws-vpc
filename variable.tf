variable "create_vpc" {
  description = "Whether the VPC is getting created"
  type = bool
  default = false
}
variable "create_igw" {
  description = "Whether IGW needs to be created"
  type = bool
  default = true
}
variable "igw_tag" {
  description = "Mention Tag needs to be associated with internet gateway"
  type = string
  default = "my_igw"
}
variable "create_egress_only_igw" {
  description = "Whether egress only igw needs to be created"
  type = bool
  default = false
}
variable "egress_igw_tag" {
  description = "Tag name for Egress IGW"
  type = string
  default = "Egress_IGW_Tag"
}
variable "public_route_table_tag" {
  description = "Tag name for public route table"
  type = string
  default = "Public route table"
}
variable "private_route_table_tag" {
  description = "Tag for private route table"
  type = string
  default = "private_route_table_tag"
}
variable "database_route_table_tag" {
  description = "Tage for database route table"
  type = string
  default = "DB_route_table_tag"
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
#variable "ingress_from_port" {
#  description = "Ingresss port number for security group"
#  type = number
#  default = 80
#}

#variable "default_route_table_propagating_vgws" {
#  description = "List of virtual gateways"
#  type = list(string)
#  default = ["",""]
#}

#variable "dhcp_options_domain_name" {
 # description = "Mention the DHCP optoin domain name"
#  type = string
#  default = "my DHCP"
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
variable "public_subnet_tag" {
  description = "Tag for public subnet"
  type = string
  default = "public_subnet_tag"
}
variable "private_subnet_count" {
  description = "Count of private subnet"
  type = bool
  default = true
}
variable "database_subnets" {
  description = "CIDR block for database subnet"
  type = string
  default = "10.0.4.0/24"
}
#variable "ipv6_cidr_block_private" {
#  description = "IPv6 for database subnet"
#  type = string
#  default = ""
#}
#variable "ipv6_cidr_block_public" {
#  description = "IPv6 CIDR Block for public subnet"
#  type = string
#  default = ""
#}
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
variable "private_subnets_cidr" {
  description = "Cidr Blocks"
  type = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}
variable "private_subnet_tag" {
  description = "Tag for Private Subnet"
  type = string
  default = "private_subnet_tag"
}
variable "database_subnet_tag" {
  description = "Tag for Private Subnet"
  type = string
  default = "database_subnet_tag"
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
variable "default_vpc_enable_dns_support" {
  description = "Whether dns support needs to be enabled"
  type = bool
  default = true
}
variable "default_vpc_enable_dns_hostnames" {
  description = "Whether dns hostname needs to be enabled"
  type = bool
  default = true
}
variable "default_vpc_enable_classiclink" {
  description = "Whether classiclink needs to be enabled"
  type = bool
  default = true
}
variable "default_vpc_tag" {
  description = "Tag for default VPC"
  type = string
  default = "Default VPC Tag"
}

variable "public_route_table_association_required" {
  description = "Whether public route table association required"
  type = bool
  default = true
}

