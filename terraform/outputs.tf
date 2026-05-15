output "server_public_ip" {
  description = "Public IP of SkillPulse server"
  value       = aws_instance.skillpulse_server.public_ip
}

output "server_public_dns" {
  description = "Public DNS of SkillPulse server"
  value       = aws_instance.skillpulse_server.public_dns
}

output "app_url" {
  description = "Application URL"
  value       = "http://${aws_instance.skillpulse_server.public_ip}"
}
