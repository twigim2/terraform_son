data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "aws14-terraform-state"
        key = "infra/vpc/terraform.tfstate"
        region = "ap-northeast-2"
    }
}

data "terraform_remote_state" "seg" {
    backend = "s3"
    config = {
        bucket = "aws14-terraform-state"
        key = "infra/ec2/security_group/terraform.tfstate"
        region = "ap-northeast-2"
    }
}