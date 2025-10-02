provider "aws" {
    region = "eu-central-1"
}

data "aws_vpc" "default" {
    default = true 
}

resource "aws_security_group" "ssh" {
    for_each = toset(var.ssh_groups)
    description = "ssh"
    name = each.value
    vpc_id = data.aws_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

module "sg_web" {
    source = "./moduls/security_group"
    name = "web_server_sg"
    description = "http/https"
    vpc_id = data.aws_vpc.default.id
    ingress_ports = [22, 80, 443, 8080, 8443]
}

module "ec2" {
    name = var.name
    source  = "./moduls/ec2"
    ami = "ami-03a71cec707bfc3d7"
    instance_type = var.instance_type
    security_group_ids = [module.sg_web.sg_id]
}

module "vpc"{
    source = "./moduls/vpc"
    name = var.name
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
}

