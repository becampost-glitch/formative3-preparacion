resource "aws_s3_bucket" "biblioteca" {
  # Función format() para construir el nombre del bucket
  bucket        = format("%s-%s-%s-materiales", var.proyecto, var.aplicacion, var.ambiente)
  force_destroy = true

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-materiales", var.proyecto, var.aplicacion, var.ambiente)
  })
}

resource "aws_s3_bucket_versioning" "biblioteca" {
  bucket = aws_s3_bucket.biblioteca.id

  # Condicional: Enabled en prod, Suspended en dev
  versioning_configuration {
    status = var.es_prod ? "Enabled" : "Suspended"
  }
}