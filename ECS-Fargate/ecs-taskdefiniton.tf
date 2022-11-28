resource "aws_ecs_task_definition" "TD" {
  family = "Main-TD"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn = aws_iam_role.iam-role.arn
  network_mode = "awsvpc"
  cpu = 1024
  memory = 2048
  
  container_definitions = jsonencode([
    {
      name      = "main-container"
      image     = "728738226157.dkr.ecr.us-east-1.amazonaws.com/nginx-images"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
}