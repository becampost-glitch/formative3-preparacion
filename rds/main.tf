resource "aws_db_subnet_group" "rds" {
  name       = "${var.nombre_prefijo}-db-subnet-group"
  subnet_ids = var.subredes_privadas_ids

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-db-subnet-group"
  })
}

resource "aws_db_instance" "mysql" {
  identifier             = "${var.nombre_prefijo}-mysql"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [var.sg_rds_id]
  publicly_accessible    = false
  skip_final_snapshot    = true

  # Condicional: Multi-AZ en prod (true), Single-AZ en dev (false)
  multi_az = var.es_prod

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-mysql"
  })
}