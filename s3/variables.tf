variable "proyecto" {
  description = "Nombre del proyecto"
  type        = string
}

variable "aplicacion" {
  description = "Nombre de la aplicación"
  type        = string
}

variable "ambiente" {
  description = "Ambiente de despliegue (dev o prod)"
  type        = string
}

variable "es_prod" {
  description = "Booleano que indica si el ambiente es producción"
  type        = bool
}

variable "common_tags" {
  description = "Etiquetas comunes heredadas de la raíz"
  type        = map(string)
}