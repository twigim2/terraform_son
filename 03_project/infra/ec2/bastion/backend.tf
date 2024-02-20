terraform {
    backend "s3" {
        bucket = "aws14-terraform-state"
        region = "ap-northeast-2"
        key = "infra/ec2/bastion/terraform.tfstate"
        dynamodb_table = "aws14-terraform-locks"
        encrypt = true
    }
}