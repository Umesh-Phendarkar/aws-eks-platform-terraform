resource "aws_vpc" "main" {

  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "genai-vpc"
  }
}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "genai-igw"
  }
}

resource "aws_subnet" "private" {

  count = 2

  vpc_id = aws_vpc.main.id

  cidr_block = cidrsubnet(
    aws_vpc.main.cidr_block,
    8,
    count.index
  )

  availability_zone = element(
    ["us-east-1a", "us-east-1b"],
    count.index
  )

  map_public_ip_on_launch = true

  tags = {

    Name = "genai-subnet-${count.index}"

    "kubernetes.io/cluster/genai-eks-cluster" = "shared"

    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_route_table" "rt" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "genai-route-table"
  }
}

resource "aws_route_table_association" "rta" {

  count = 2

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.rt.id
}
