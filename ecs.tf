resource "aws_ecs_cluster" "rails-webapp-cluster" {
  name = "rails-webapp-cluster"
}

resource "aws_ecs_service" "rails-service" {
  name            = "rails-service"
  cluster         = aws_ecs_cluster.rails-webapp-cluster.id
  task_definition = aws_ecs_task_definition.rails-task.arn
  desired_count   = 1
  launch_type     = "EC2"
}

resource "aws_ecs_task_definition" "rails-task" {
  family                = "rails-service"
  container_definitions = file("./container_definitions.json")
  task_role_arn         = module.ecs_task_role.iam_role_arn
  network_mode          = "bridge"
}
