variable "name" {}
variable "instance_type" {}
variable "ssh_groups" {
  default = ["ssh-1", "ssh-2", "ssh-3"]
}
