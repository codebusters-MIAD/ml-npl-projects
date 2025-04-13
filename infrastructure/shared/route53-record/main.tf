#=======================================================================================================================
# AWS ROUTE53 MODULE
#=======================================================================================================================
resource "aws_route53_record" "route53_record" {
  name    = var.record_name
  type    = var.record_type
  zone_id = var.record_zone_id

  alias {
    name                   = var.record_alias_name
    zone_id                = var.record_alias_zone_id
    evaluate_target_health = var.record_alias_eval_health
  }
}