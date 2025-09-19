# HTTP リスナー設定

resource "aws_alb_listener" "http_listener_forward" {
  # alb_listener_enable_httpがtrue、alb_listener_enable_redirect_http_to_httpsが
  # alseの場合にHTTPリスナーを作成する
  count = (
    var.alb_enable_http_listener &&
  !var.alb_enable_redirect_http_to_https) ? 1 : 0

  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }

  tags = local.alb_tags
}

resource "aws_alb_listener" "https_listener_redirect" {
  # alb_listener_enable_httpがtrue、alb_listener_enable_redirect_http_to_httpsが
  # trueの場合にHTTPリスナーを作成する
  count = (
    var.alb_enable_http_listener &&
  var.alb_enable_redirect_http_to_https) ? 1 : 0

  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTP"
  port              = 80

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = local.alb_tags

}

# HTTPS リスナー設定

resource "aws_alb_listener" "https_listener" {
  # alb_listener_enable_httpsがtrueの場合にHTTPSリスナーを作成する
  count = var.alb_enable_https_listener ? 1 : 0

  load_balancer_arn = aws_lb.alb.arn
  protocol          = "HTTPS"
  port              = 443
  ssl_policy        = var.alb_https_listener_ssl_policy
  certificate_arn   = var.alb_https_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }

  tags = local.alb_tags
}
