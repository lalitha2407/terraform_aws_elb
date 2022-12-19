resource "aws_elb" "elastic_loadbalancer" {
  name               = var.name
  availability_zones = var.availability_zones
  idle_timeout       = var.idle_timeout
  internal           = var.internal
  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  dynamic "access_logs" {
    for_each = var.access_logs ? [{}] : []
    content {
      bucket   = var.bucket
      interval = var.interval
      enabled  = true
    }
  }


  dynamic "health_check" {
    for_each = var.health_check ? [{}] : []
    content {
      healthy_threshold   = var.healthy_threshold
      unhealthy_threshold = var.unhealthy_threshold
      target              = var.target
      timeout             = var.timeout
      interval            = var.interval
    }

  }

  dynamic "listener" {
    for_each = var.listener ? [{}] : []
    content {
      instance_port     = var.instance_port
      instance_protocol = var.instance_protocol
      lb_port           = var.lb_port
      lb_protocol       = var.lb_protocol

    }
  }
}