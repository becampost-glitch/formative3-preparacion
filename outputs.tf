output "nlb_dns_name" {
  description = "DNS público del Network Load Balancer"
  value       = module.nlb.nlb_dns_name
}

output "rds_endpoint" {
  description = "Endpoint de conexión de la base de datos RDS MySQL"
  value       = module.rds.rds_endpoint
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3 creado"
  value       = module.s3.s3_bucket_name
}

output "servidores_ips_publicas" {
  description = "IPs públicas de los servidores EC2 para conectarse por SSH"
  value       = module.ec2.instancias_ips_publicas
}