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
