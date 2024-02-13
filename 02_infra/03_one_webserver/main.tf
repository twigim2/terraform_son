provider "aws" {
    region = "ap-northeast-2"
}

resource "aws_instance" "example" {
    ami = "ami-09eb4311cbaecf89d"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.web.id, aws_security_group.ssh.id]
    key_name = "aws14-key"

    user_data = <<-EOF
                    #!/bin/bash
                    echo "Hello, World" > index.html
                    nohup busybox httpd -f -p 8080 &
                    EOF

    tags = {
        Name = "aws14-webserver"
    }
}

resource "aws_security_group" "web" {
    name = "aws14-example-instance-web"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ssh" {
    name = "aws14-example-instance-ssh"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "public_ip" {
    value = aws_instance.example.public_ip
    description = "The public IP of the Instance"
}