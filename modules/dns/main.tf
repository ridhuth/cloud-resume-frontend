resource "aws_route53_zone" "main" {
  name = "rhresume.com"
}


resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "rhresume.com"
  type    = "A"
  alias {
    name  = var.root_alias_name
    zone_id = var.root_target_zone_id
    evaluate_target_health = false

  }

}


resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "www.rhresume.com"
  type    = "A"
  alias {
    name  = var.www_alias_name
    zone_id = var.www_target_zone_id
    evaluate_target_health = false

  }

}