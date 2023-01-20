output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "Vpc-ID" {
  value = aws_vpc.vpc.id
}

output "subnet-1-cidr_block" {
  value = aws_subnet.subnet1.cidr_block
}

output "subnet-1-id" {
  value = aws_subnet.subnet1.id
}

output "subnet-2-cidr_block" {
  value = aws_subnet.subnet2.cidr_block
}

output "subnet-2-id" {
  value = aws_subnet.subnet2.id
}

output "EC2-Instance1" {
  value = aws_instance.EC2-One.id
}

output "EC2-Instance2" {
  value = aws_instance.EC2-Two.id
}

output "Security-Group" {
  value = aws_security_group.security_group.id
}

output "Target-Group" {
  value = aws_lb_target_group.TG.arn
}

output "Load-Balancer" {
  value = aws_lb.Load-Balancer.id
}

output "subnet1" {
  value = element(aws_subnet.subnet1.*.id, 1)
}

output "subnet2" {
  value = element(aws_subnet.subnet2.*.id, 2)
}