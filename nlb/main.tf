resource "aws_lb" "nlb" {
  name               = "${var.nombre_prefijo}-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.subredes_publicas_ids

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-nlb"
  })
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.nombre_prefijo}-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "TCP"
    port     = "80"
  }

  tags = merge(var.common_tags, {
    Name = "${var.nombre_prefijo}-tg"
  })
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# Ciclo for_each para registrar los 3 servidores como targets del NLB
resource "aws_lb_target_group_attachment" "targets" {
  for_each = var.instancias_ids

  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = each.value
  port             = 80
}