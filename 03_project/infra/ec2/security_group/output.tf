output "aws_security_group_http" {
    value = aws_security_group.http.id
}

output "aws_security_group_https" {
    value = aws_security_group.https.id
}

output "aws_security_group_ssh" {
    value = aws_security_group.ssh.id
}