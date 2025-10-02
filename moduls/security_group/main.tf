resource "aws_security_group" "this" {
    name = var.name
    vpc_id = var.vpc_id
    description = "http/https"
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#Динамічно створюємо SG
resource "aws_security_group_rule" "ingress" {
    for_each = {
        for i in var.ingress_ports : i => i
    }
    type = "ingress"
    from_port = each.value 
    to_port = each.value
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.this.id
}