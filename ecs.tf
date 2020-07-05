resource "aws_ecs_cluster" "rails-webapp-cluster" {
  name = "rails-webapp-cluster"
}

resource "aws_ecs_service" "rails-service" {
  name            = "rails-service"
  cluster         = aws_ecs_cluster.rails-webapp-cluster.id
  task_definition = aws_ecs_task_definition.rails-task.arn
  desired_count   = 1
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.http.arn
    container_name   = "rails_webapp"
    container_port   = "3000"
  }
}

resource "aws_ecs_task_definition" "rails-task" {
  family                = "rails-service"
  container_definitions = file("./container_definitions.json")
  task_role_arn         = module.ecs_task_role.iam_role_arn
  network_mode          = "bridge"
}
