resource "aws_ecs_task_definition" "demo_task" {
  family                   = "demo-task"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "demo-app",
      "image": "${var.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 8000,
          "hostPort": 8000
        }
      ],
      "memory": 512,
      "cpu": 256,
      "environment": [
       {
         "name": "WELCOME_MSG", 
         "value": "Hello World"
       }
      ]
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecsTaskExecutionRole.arn
}
