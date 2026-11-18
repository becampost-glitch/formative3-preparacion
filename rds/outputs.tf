output "rds_endpoint" {
  description = "Endpoint de conexión de la base de datos RDS MySQL"
  value       = aws_db_instance.mysql.endpoint
}