output "aws_instance_public_dns" {
  value       = "http://${aws_lb.nginx.dns_name}"
  description = "Public DNS hostname for the EC2 instance"
}