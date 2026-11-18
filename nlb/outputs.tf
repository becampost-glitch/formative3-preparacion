output "nlb_dns_name" {
  description = "DNS público del Network Load Balancer"
  value       = aws_lb.nlb.dns_name
}