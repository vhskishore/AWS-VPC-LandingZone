resource "aws_route_table" "private_rt_a" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, {})
}

resource "aws_route_table_association" "rt_private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rt_a.id
}

resource "aws_route" "route_pa" {
  route_table_id         = aws_route_table.private_rt_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw-2a-public.id
}

resource "aws_route_table" "rt_private_b" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.tags, {})
}

resource "aws_route_table_association" "rt_assoc_private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.rt_private_b.id
}

resource "aws_route" "route_pb" {
  route_table_id         = aws_route.table.rt_private_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw-2b-public.id
}

resource "aws_route_table" "rt_private_c" {
  vpc_id = aws_vpc.amc-vpc.id
  tags   = merge(var.tags, {})
}

resource "aws_route_table_association" "rt_assoc_private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.rt_private_c.id
}

resource "aws_route" "route_pc" {
  route_table_id         = aws_route_table.rt_private_c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gw-2c-public.id
}

resource "aws_subnet" "private_a" {
  vpc_id                 = aws_vpc.amc-vpc.id
  tags                   = merge(var.tags, {})
  map_public_ip_on_lunch = false
  cidr_block             = var.private_subnets.a
  availability_zone      = "us-east-1a"
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.vpc.id
  tags                    = merge(var.tags, {})
  map_public_ip_on_launch = false
  cidr_block              = var.private_subnets.b
  availability_zone       = "us-east-1b"
}

resource "aws_subnet" "private_c" {
  vpc_id                  = aws_vpc.vpc.id
  tags                    = merge(var.tags, {})
  map_public_ip_on_launch = false
  cidr_block              = var.private_subnet.c
  availability_zone       = "us-east-1c"
}