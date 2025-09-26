resource "aws_vpc" "my_vpc" {
    cidr_block           = var.cidr_block
    instance_tenancy     = var.instance_tenancy
    enable_dns_support   = true 
    enable_dns_hostnames = true
    
    tags = {
        Name = "my_vpc"
    }
}

resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
        Name = "Gateway"
    }
}

#----------Public subnet------------
resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.my_vpc.id
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "eu-central-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "Public_subnet"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    }

    tags = {
        Name = "Public_rt"
    }
}

resource "aws_route_table_association" "public_rt_connection" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

#-------------Private subnet----------------
resource "aws_subnet" "private_subnet" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "eu-central-1a"
    map_public_ip_on_launch = false

    tags = {
        Name = "Private_subnet"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
        Name = "Private_rt"
    }
}

resource "aws_route_table_association" "private_rt_connection" {
    subnet_id      = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}
