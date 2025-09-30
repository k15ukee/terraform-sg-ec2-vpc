output "ssh_ids" {
    value = aws_security_group.ssh[*].id
}
output "web_id" {
    value = aws_security_group.web.id
}