##################################################################################
# DATA
##################################################################################

data "aws_availability_zones" "available" {
  state = "available"
}

# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.aws_vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = local.common_tags

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags
}

resource "aws_subnet" "subnet1" {
  cidr_block              = var.aws_public_subnet_cidr_block[0]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags                    = local.common_tags
}

resource "aws_subnet" "subnet2" {
  cidr_block              = var.aws_public_subnet_cidr_block[1]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags                    = local.common_tags
}

# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta-subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_route_table_association" "rta-subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rtb.id
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags


  # HTTP access from anywhere
  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = [var.aws_vpc_cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "alb_sg" {
  name   = "nginx_alb_sg"
  vpc_id = aws_vpc.vpc.id
  tags   = local.common_tags


  # HTTP access from anywhere
  ingress {
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = ["0.0.0.0/0"]
  }
}