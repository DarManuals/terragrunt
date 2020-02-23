resource "aws_vpc" "my_vpc" {
  cidr_block = "10.1.0.0/24"
  tags = {
    Name = "vpc-${var.name}"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw-${var.name}"
  }
}

resource "aws_subnet" "private_subnet" {
  cidr_block        = "10.1.0.0/25"
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = var.az_a
  tags = {
    Name = "private_subnet-${var.name}"
    az   = var.az_a
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = "10.1.0.128/25"
  vpc_id                  = aws_vpc.my_vpc.id
  availability_zone       = var.az_b
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet-${var.name}"
    az   = var.az_b
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public_route_table-${var.name}"
  }
}

resource "aws_route_table_association" "public_route_assoc" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}