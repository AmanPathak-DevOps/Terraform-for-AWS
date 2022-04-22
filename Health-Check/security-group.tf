resource "aws_security_group" "Security-Group" {
    vpc_id = aws_vpc.vpc.id
    
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/16"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "Aman-SG"
    }
}