resource "aws_ecs_cluster" "ECS" {
  name = "Main-Cluster"

  tags = {
    Name = "Main-Cluster"
  }
}   