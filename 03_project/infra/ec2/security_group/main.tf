resource "aws_security_group" "ssh" {
    name = "aws14-instance-ssh"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    ingress {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http" {
    name = "aws14-instance-http"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    ingress {
        from_port = var.http_port
        to_port = var.http_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "https" {
    name = "aws14-instance-https"
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    ingress {
        from_port = var.https_port
        to_port = var.https_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}