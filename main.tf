


# NETWORKING FOR Grace IT Group 

resource "aws_vpc" "Grace_IT_Group" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.dns-hostnames
  enable_dns_support   = var.dns-support


  tags = {
    Name = "Grace IT Group"
    Env  = "Prod"
  }
}


# TWO PUBLIC SUBNETS FOR THE NETWORK

resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id     = aws_vpc.Grace_IT_Group.id
  cidr_block = var.pub-sub1

  tags = {
    Name = "Prod-pub-sub1"
    Env  = "Prod"
  }
}

resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id     = aws_vpc.Grace_IT_Group.id
  cidr_block = var.pub-sub2

  tags = {
    Name = "Prod-pub-sub2"
    Env  = "Prod"
  }
}


# TWO PRIVATE SUBNETS FOR THE NETWORK

resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id     = aws_vpc.Grace_IT_Group.id
  cidr_block = var.priv-sub1

  tags = {
    Name = "Prod-priv-sub1"
    Env  = "Prod"
  }
}

resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id     = aws_vpc.Grace_IT_Group.id
  cidr_block = var.priv-sub2

  tags = {
    Name = "Prod-priv-sub2"
    Env  = "Prod"
  }
}


# CREATING INTERNET GATEWAY

resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.Grace_IT_Group.id

  tags = {
    Name = "Prod-igw"
    Env  = "Prod"
  }
}



# CREATING EIPs for NAT GATEWAY

resource "aws_eip" "nat" {
  depends_on = [aws_internet_gateway.Prod-igw]
}



# CREATING NAT GATEWAY

resource "aws_nat_gateway" "Prod-ngw" {
  allocation_id     = aws_eip.nat.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.Prod-pub-sub1.id

  tags = {
    Name = "Prod-ngw"
    Env  = "Prod"
  }
}




# TWO ROUTE TABLES FOR THE NETWORK

resource "aws_route_table" "Prod-pub-RT" {
  vpc_id = aws_vpc.Grace_IT_Group.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Prod-igw.id
  }

  tags = {
    Name = "Prod-pub-route-table"
    Env  = "Prod"
  }
}

resource "aws_route_table" "Prod-priv-RT" {
  vpc_id = aws_vpc.Grace_IT_Group.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Prod-ngw.id

  }

  tags = {
    Name = "Prod-priv-route-table"
    Env  = "Prod"
  }
}



# ROUTE TABLE ASSOCIATIONS

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-RT.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-RT.id
}


resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-RT.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.Prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-RT.id
}



