variable "create_vpc" {
  description = "Whether the VPC is getting created"
  type = bool
  default = false
}

variable "cidr" {}
variable "instance_tenancy" {
  description = "Instance will be shared, dedicated and host. 'default' is shared"
  type = string
  default = "default"
}

variable "enable_dns_hostnames" {
  desctiption = "Enable DNS Hostname"
  type = bool
  defualt = false
}

variable "enable_dns_support" {
  desctiption = "Enable DNS Support"
  type = bool
  defualt = false
}

variable "enable_classiclink" {
  desctiption = "A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type = bool
  defualt = false
}

variable "enable_classiclink_dns_support" {
  desctiption = "A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type = bool
  defualt = false
}

variable "enable_ipv6" {
  desctiption = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
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

variable "secondary_cidr" {}
variable "default_security_group_name" {}

variable "enable_dhcp_options" {
  description = "Enable DHCP options.. True or False"
  type = bool
  default = false
}

variable "manage_default_route_table" {
  description = "Are we managing default route table"
  type = bool
  string = false
}

variable "default_route_table_propagating_vgws" {
  description = "List of virtual gateways"
  type = list(string)
  default = ["",""]
}

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
  default = {""}
}

variable "map_public_ip_on_launch" {
  description = "It will map the public ip while launching resources"
  type = bool
  default = true
}

variabl "public_subnet_assign_ipv6_address_on_creation" {
  description = "IPv6 address to be assinged to resources"
  type = bool
  default = false
}

variable "ipv6_cidr_block_public" {
  description = "IPv6 cidr block to be used"
  type = list(string)
  default = {""}
}

variabl "private_subnet_assign_ipv6_address_on_creation" {
  description = "IPv6 address to be assinged to resources"
  type = bool
  default = false
}

variable "ipv6_cidr_block_private" {
  description = "IPv6 cidr block to be used"
  type = list(string)
  default = {""}
}
variable "database_subnets_count" {
  description "Enter the number of subnets required for DB"
  type = number
  default = 2
}

variable "db_subnet_group_name" {
  description = "Name of the subnet group created"
  type = string
  default = "my_subnet_group"
}

