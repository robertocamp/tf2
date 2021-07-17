


resource "aws_security_group" "wordpress_elb" {
  name        = "wordpress-elb-sg"
  description = "Allow http/s traffic from the internet and forward to wordpress instance"
  vpc_id      = "${var.vpc_id}" ## from  TF1  project
ingress {
     from_port       = 80
     to_port         = 80
     protocol        = "tcp"
     cidr_blocks = ["0.0.0.0/0"] ## whole internet
  }
egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    source_security_group_id     = aws_security_group.wordpress_instance.id
  }
}
resource "aws_security_group" "wordpress_instance" {
  name        = "wordpress-instance-sg"
  description = "Allow http traffic from load balancer"
  vpc_id      = "${var.vpc_id}" ## from the first article
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

# after these groups are provisioned we will create a fule for instance security group

resource "aws_security_group_rule" "wordpress-instance-from-load-balancer" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  security_group_id = aws_security_group.wordpress_instance.id
  source_security_group_id = aws_security_group.wordpress_elb.id
}
resource "aws_security_group_rule" "wordpress-load-balancer-to-instance" {
type      = "egress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
security_group_id        = aws_security_group.wordpress_elb.id
  source_security_group_id = aws_security_group.wordpress_instance.id
}


resource "aws_iam_role" "wordpress_instance" {
  name = "wordpress-instance-iam-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_launch_template" "wordpress_launch_template" {
  
  name_prefix            = "wordpress"
  image_id               = "ami-00399ec92321828f5"
  instance_type          = "t2.micro"
  key_name               = "wordpress"
  vpc_security_group_ids = [aws_security_group.wordpress_instance.id]
iam_instance_profile {
    arn = aws_iam_role.wordpress_instance.arn
  }
}

resource "aws_autoscaling_group" "wordpress_asg" {
  name = "wordpress-asg"
vpc_zone_identifier = var.private_subnets ## from first article
max_size            = 10
  min_size          = 1
  desired_capacity  = 1
health_check_grace_period = "600"
  health_check_type         = "EC2"
mixed_instances_policy {
launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.wordpress_launch_template.id
        version            = aws_launch_template.wordpress_launch_template.latest_version
      }
    }
  }
}

