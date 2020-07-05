resource "aws_security_group" "ecs_instance" {
  name   = "ecs_instance"
  vpc_id = aws_vpc.vpc.id
}
