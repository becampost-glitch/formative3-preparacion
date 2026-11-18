variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

variable "proyecto" {
  description = "Nombre del proyecto"
  type        = string
}

variable "aplicacion" {
  description = "Nombre de la aplicación"
  type        = string
}

variable "responsable" {
  description = "Equipo o persona responsable"
  type        = string
}

variable "ambiente" {
  description = "Ambiente de despliegue (dev o prod)"
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.ambiente)
    error_message = "El ambiente debe ser 'dev' o 'prod'."
  }
}

variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subredes" {
  description = "Mapa de las 4 subredes (2 públicas y 2 privadas)"
  type = map(object({
    cidr    = string
    az      = string
    publica = bool
  }))
}

variable "servidores" {
  description = "Mapa de objetos con la configuración de los servidores"
  type = map(object({
    tipo_instancia = string
    disco_base     = number
    subred_key     = string
  }))
}

variable "key_name" {
  description = "Nombre del Key Pair en AWS para conectarse por SSH"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos MySQL"
  type        = string
  default     = "bibliotecadb"
}

variable "db_username" {
  description = "Usuario administrador de la RDS"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Contraseña de la RDS"
  type        = string
  sensitive   = true
}