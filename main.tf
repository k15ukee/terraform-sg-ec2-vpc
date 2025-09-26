provider "aws" {
    region = "eu-central-1"
}

data "aws_vpc" "default" {
    default = true 
}

module "sg_web" {
    source = "./moduls/security_group"
    name = "web_server_sg"
    description = "security groput with allow ssh, http and https"
    vpc_id = data.aws_vpc.default.id
}

module "ec2" {
    name = var.name
    source  = "./moduls/ec2"
    ami = "ami-03a71cec707bfc3d7"
    instance_type = var.instance_type
    security_group_id = module.sg_web.id
    
}

module "vpc"{
    source = "./moduls/vpc"
    name = var.name
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
}

