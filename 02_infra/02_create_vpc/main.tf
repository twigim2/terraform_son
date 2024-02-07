resource "aws_vpc" "aws14-vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "aws14-vpc"
    }
}

// subnet 생성
// ap-northeast-2a
// public
resource "aws_subnet" "aws14-public-subnet-2a" {
    vpc_id = aws_vpc.aws14-vpc.id
    cidr_block = var.public_subnet[0]
    availability_zone = var.azs[0]
    tags = {
        Name = "aws14-public-subnet-2a"
    }
}
// private
resource "aws_subnet" "aws14-private-subnet-2a" {
    vpc_id = aws_vpc.aws14-vpc.id
    cidr_block = var.private_subnet[0]
    availability_zone = var.azs[0]
    tags = {
        Name = "aws14-private-subnet-2a"
    }
}
// ap-northeast-2c
// public
resource "aws_subnet" "aws14-public-subnet-2c" {
    vpc_id = aws_vpc.aws14-vpc.id
    cidr_block = var.public_subnet[1]
    availability_zone = var.azs[1]
    tags = {
        Name = "aws14-public-subnet-2c"
    }
}

// private
resource "aws_subnet" "aws14-private-subnet-2c" {
    vpc_id = aws_vpc.aws14-vpc.id
    cidr_block = var.private_subnet[1]
    availability_zone = var.azs[1]
    tags = {
        Name = "aws14-private-subnet-2c"
    }
}

// GATE WAY
resource "aws_internet_gateway" "aws14-igw" {
  vpc_id = aws_vpc.aws14-vpc.id

  tags = {
    Name = "aws14-igw"
  }
}

// EIP
resource "aws_eip" "aws14-eip" {
    domain = "vpc"
    depends_on = [ "aws_internet_gateway.aws14-igw" ]
    lifecycle {
      create_before_destroy = true
    }
    tags = {
        Name = "aws14-eip"
    }
}

// NAT GATE WAY
resource "aws_nat_gateway" "aws14-nat" {
    allocation_id = aws_eip.aws14-eip.id
    subnet_id = aws_subnet.aws14-public-subnet-2a.id
    depends_on = ["aws_internet_gateway.aws14-igw"]

    tags = {
        Name = "aws14-nat"
    }
}

// ROUTER
## public route table
resource "aws_default_route_table" "aws14-public-rt-table" {
    default_route_table_id = aws_vpc.aws14-vpc.default_route_table_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.aws14-igw.id
    }
    tags = {
        Name = "aws14-public-rt-table"
    }
}

resource "aws_route_table_association" "aws14-public-rt-2a" {
    subnet_id = aws_subnet.aws14-public-subnet-2a.id
    route_table_id = aws_default_route_table.aws14-public-rt-table.id
}

resource "aws_route_table_association" "aws14-public-rt-2c" {
    subnet_id = aws_subnet.aws14-public-subnet-2c.id
    route_table_id = aws_default_route_table.aws14-public-rt-table.id
}

## private route table
resource "aws_route_table" "aws14-private-rt-table" {
    vpc_id = aws_vpc.aws14-vpc.id
    tags = {
        Name = "aws14-private-rt-table"
    }
}

## private route
resource "aws_route" "aws14-private-rt" {
    route_table_id = aws_route_table.aws14-private-rt-table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws14-nat.id
}

resource "aws_route_table_association" "aws14-private-rt-2a" {
    subnet_id = aws_subnet.aws14-private-subnet-2a.id
    route_table_id = aws_route_table.aws14-private-rt-table.id
}

resource "aws_route_table_association" "aws14-private-rt-2c" {
    subnet_id = aws_subnet.aws14-private-subnet-2c.id
    route_table_id = aws_route_table.aws14-private-rt-table.id
}