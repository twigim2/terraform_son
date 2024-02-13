resource "aws_launch_template" "example" {
    name = "aws14-example-template"
    image_id = "ami-07b16ccbfcade442c"
    instance_type = "t2.micro"
    key_name = "aws14-key"
    vpc_security_group_ids = [aws_security_group.web.id, aws_security_group.ssh.id]
}

resource "aws_security_group" "web" {
    name = "aws14-example-web"
    
    ingress {
        from_port = var.web_port
        to_port = var.web_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ssh" {
    name = "aws14-example-ssh"
    
    ingress {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}