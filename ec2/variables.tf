variable "servidores" {
  description = "Mapa de objetos con la configuración de los servidores"
  type = map(object({
    tipo_instancia = string
    disco_base     = number
    subred_key     = string
  }))
}

variable "subredes_ids" {
  description = "Mapa con los IDs de las subredes (viene del módulo vpc)"
  type        = map(string)
}

variable "sg_ec2_id" {
  description = "ID del Security Group para las EC2 (viene del módulo vpc)"
  type        = string
}

variable "key_name" {
  description = "Nombre del Key Pair en AWS para conectarse por SSH"
  type        = string
}

variable "es_prod" {
  description = "Booleano que indica si el ambiente es producción"
  type        = bool
}

variable "ambiente" {
  description = "Nombre del ambiente (dev o prod)"
  type        = string
}

variable "nombre_prefijo" {
  description = "Prefijo para nombrar los recursos (ej: eduandes-dev)"
  type        = string
}

variable "common_tags" {
  description = "Etiquetas comunes heredadas de la raíz"
  type        = map(string)
}