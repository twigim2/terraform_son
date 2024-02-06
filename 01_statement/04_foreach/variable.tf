variable "user_names" {
    description = "Create IAM users with these names"
    type = list(string)
    default = ["aws14-neo", "aws14-trinity", "aws14-morpheus"]
}