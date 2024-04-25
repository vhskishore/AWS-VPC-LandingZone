resource "aws_vpc" "vpc" {
  tags       = merge(var.tags, {})
  cidr_block = var.vpc_cidr
}