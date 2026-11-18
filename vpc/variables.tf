variable "vpc_cidr" {
  description = "Bloque CIDR de la VPC"
  type        = string
}

variable "subredes" {
  description = "Mapa de las 4 subredes (2 públicas y 2 privadas)"
  type = map(object({
    cidr    = string
    az      = string
    publica = bool
  }))
}

variable "nombre_prefijo" {
  description = "Prefijo para nombrar los recursos (ej: eduandes-dev)"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes heredadas de la raíz"
  type        = map(string)
}