variable "subredes_privadas_ids" {
  description = "Lista de IDs de las subredes privadas (viene del módulo vpc)"
  type        = list(string)
}

variable "sg_rds_id" {
  description = "ID del Security Group para la base de datos RDS (viene del módulo vpc)"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos MySQL"
  type        = string
}

variable "db_username" {
  description = "Usuario administrador de la RDS"
  type        = string
}

variable "db_password" {
  description = "Contraseña de la RDS"
  type        = string
  sensitive   = true
}

variable "es_prod" {
  description = "Booleano que indica si el ambiente es producción"
  type        = bool
}

variable "nombre_prefijo" {
  description = "Prefijo para nombrar los recursos (ej: eduandes-dev)"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes heredadas de la raíz"
  type        = map(string)
}