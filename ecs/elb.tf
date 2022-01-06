resource "aws_lb" "application_load_balancer" {
  name               = "django-app-lb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
  security_groups    = [aws_security_group.load-balancer.id]
}

resource "aws_lb_target_group" "target_group" {
  name        = "django-target-group"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.production-vpc.id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
