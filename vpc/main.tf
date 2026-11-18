resource "aws_vpc" "principal" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-vpc"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.principal.id

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-igw"
  })
}

# Ciclo for_each para crear las 4 subredes con un solo bloque
resource "aws_subnet" "principal" {
  for_each = var.subredes

  vpc_id                  = aws_vpc.principal.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.publica

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-${each.key}"
  })
}

resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-rt-publica"
  })
}

resource "aws_route_table_association" "publica" {
  for_each = { for k, v in var.subredes : k => v if v.publica }

  subnet_id      = aws_subnet.principal[each.key].id
  route_table_id = aws_route_table.publica.id
}

resource "aws_security_group" "servidores" {
  name        = "${var.nombre_prefijo}-sg-ec2"
  description = "Permite trafico HTTP desde NLB/Internet y SSH"
  vpc_id      = aws_vpc.principal.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-sg-ec2"
  })
}

resource "aws_security_group" "rds" {
  name        = "${var.nombre_prefijo}-sg-rds"
  description = "Permite MySQL unicamente desde los servidores EC2"
  vpc_id      = aws_vpc.principal.id

  ingress {
    description     = "MySQL desde EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.servidores.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-sg-rds"
  })
}