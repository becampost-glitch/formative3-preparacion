output "instancias_ids" {
  description = "Mapa con los IDs de las instancias EC2 creadas"
  value       = { for k, v in aws_instance.servidores : k => v.id }
}

output "instancias_ips_publicas" {
  description = "Mapa con las IPs públicas de las instancias para conectarse por SSH"
  value       = { for k, v in aws_instance.servidores : k => v.public_ip }
}