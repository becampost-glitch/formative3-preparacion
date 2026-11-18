output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.principal.id
}

output "subredes_ids" {
  description = "Mapa con los IDs de todas las subredes (clave => id)"
  value       = { for k, v in aws_subnet.principal : k => v.id }
}

output "subredes_publicas_ids" {
  description = "Lista de IDs de las subredes públicas"
  value       = [for k, v in aws_subnet.principal : v.id if var.subredes[k].publica]
}

output "subredes_privadas_ids" {
  description = "Lista de IDs de las subredes privadas"
  value       = [for k, v in aws_subnet.principal : v.id if !var.subredes[k].publica]
}

output "sg_ec2_id" {
  description = "ID del Security Group para los servidores EC2"
  value       = aws_security_group.servidores.id
}

output "sg_rds_id" {
  description = "ID del Security Group para la base de datos RDS"
  value       = aws_security_group.rds.id
}