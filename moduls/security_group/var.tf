variable "name" {}
variable "description" {}
variable "vpc_id" {}

variable "ingress_ports" {
    type = list(number)
}

variable "ssh_ports" {
    type = map(string)
    default = {
        rule_1 = "1.2.3.4/32"
        rule_2 = "5.6.7.8/32"
        rule_3 = "10.0.0.0/16"
    }
}