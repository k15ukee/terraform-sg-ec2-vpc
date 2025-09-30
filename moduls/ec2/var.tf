variable "name" {}
variable "ami" {}
variable "instance_type" {}
variable "security_group_ids" {
    type = list(string)
}