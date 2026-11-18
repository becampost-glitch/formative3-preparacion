data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_instance" "servidores" {
  for_each = var.servidores

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = each.value.tipo_instancia
  subnet_id              = var.subredes_ids[each.value.subred_key]
  vpc_security_group_ids = [var.sg_ec2_id]
  key_name               = var.key_name

  # Condicional: en prod duplica el disco base; en dev usa el disco base
  root_block_device {
    volume_size = var.es_prod ? each.value.disco_base * 2 : each.value.disco_base
    volume_type = "gp3"
  }

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx mariadb105
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Servidor: ${each.key} | Ambiente: ${var.ambiente}</h1>" > /usr/share/nginx/html/index.html
              EOF

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-${each.key}"
  })
}