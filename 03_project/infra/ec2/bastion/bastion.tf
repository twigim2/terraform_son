resource "aws_instance" "bastion" {
    ami = "ami-09eb4311cbaecf89d"
    instance_type = "t2.micro"
    key_name = "aws14-key"

    subnet_id = data.terraform_remote_state.vpc.outputs.public-subnet-2a-id
    vpc_security_group_ids = [ data.terraform_remote_state.seg.outputs.aws_security_group_ssh ]
    associate_public_ip_address = true
    tags = {
        Name = "aws14-bastion"
    }
}