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
