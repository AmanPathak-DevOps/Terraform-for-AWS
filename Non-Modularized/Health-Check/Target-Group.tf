resource "aws_lb_target_group" "TG" {
    health_check {
        interval = 10
        path = "/"
        protocol = "HTTP"
        timeout = 5
        healthy_threshold = 5
        unhealthy_threshold = 2
    }
    name = "Aman-TG"
    port = 8080
    protocol = "tcp"
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "Aman-TG"
    }
}