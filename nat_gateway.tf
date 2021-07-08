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
  subnet_id     = aws_subnet.database[0].id
  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #depends_on = [aws_internet_gateway.myIGW]
}
