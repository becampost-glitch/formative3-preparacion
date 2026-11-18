variable "vpc_id" {
  description = "ID de la VPC (viene del módulo vpc)"
  type        = string
}

variable "subredes_publicas_ids" {
  description = "Lista de IDs de las subredes públicas (viene del módulo vpc)"
  type        = list(string)
}

variable "instancias_ids" {
  description = "Mapa con los IDs de las instancias EC2 a registrar (viene del módulo ec2)"
  type        = map(string)
}

variable "nombre_prefijo" {
  description = "Prefijo para nombrar los recursos (ej: eduandes-dev)"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes heredadas de la raíz"
  type        = map(string)
}