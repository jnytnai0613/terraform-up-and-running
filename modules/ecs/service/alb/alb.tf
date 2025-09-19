resource "aws_lb" "alb" {
  name                       = local.alb_name
  internal                   = false
  enable_deletion_protection = local.alb_deletion_protect
  load_balancer_type         = "application"
  subnets                    = var.alb_subnet_ids
  security_groups            = var.alb_security_group_ids

  access_logs {
    bucket  = aws_s3_bucket.log_bucket.bucket
    enabled = true
  }

  tags = local.alb_tags
}
