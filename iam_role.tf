# ------------------------------------------------------------
# ECS Instance Role
# ------------------------------------------------------------
module "ecs_instance_role" {
  source     = "./iam_role"
  name       = "ecs_instance"
  identifier = "ec2.amazonaws.com"
  policy     = data.aws_iam_policy.ecs_for_ec2_role.policy
}

data "aws_iam_policy" "ecs_for_ec2_role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs-instance-profile"
  role = module.ecs_instance_role.iam_role_name
}

# ------------------------------------------------------------
# ECS Task Role
# ------------------------------------------------------------
module "ecs_task_role" {
  source     = "./iam_role"
  name       = "ecs_task"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy.ecs_task_execiton_role_policy.policy
}

data "aws_iam_policy" "ecs_task_execiton_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
