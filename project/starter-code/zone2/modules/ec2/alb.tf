resource "aws_lb" "alb" {
  internal = false
  subnets = var.public_subnet_ids
  security_groups = [ aws_security_group.alb_sg.id ]
}

resource "aws_lb_target_group" "alb_tg" {
  port = "80"
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  vpc_id      = var.vpc_id

  ingress {    
    description = "web port"
    from_port   = 80    
    to_port     = 80
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh port"
    from_port   = 22    
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "monitoring"
    from_port   = 9100    
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment_1" {
  count = var.instance_count

  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id = aws_instance.ubuntu[count.index].id
  port = 80
}