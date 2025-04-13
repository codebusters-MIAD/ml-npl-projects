
module "ec2_cw_alarm" {
  source      = "../cloudwatch-alarms/ec2-instance"
  environment = var.environment
  namespace   = var.namespace
  app_name    = var.tag_name

  default_sns_topic_arn = var.sns_topic_cw_email_notification_arn

  ec2_info = {
    instanceId   = aws_instance.ec2_instance.id
    instanceType = var.instance_type
    imageId      = var.ami_base_image_id
  }

  monitor_ec2_disk_used_percent = true
  monitor_ec2_mem_used_percent  = true

  tags = var.tags
}

module "aws_ec2_cw_alarm_app_server_error" {
  source = "../../shared/cloudwatch-alarms/application-errors"
  environment = var.environment
  namespace = var.namespace
  app_name = var.tag_name

  default_sns_topic_arn = var.sns_topic_cw_email_notification_arn

  cw_log_group_name = module.ec2_cw_alarm.log_group_name

  tags = var.tags
}

#resource "aws_cloudwatch_dashboard" "annotation_tool_server_dashboard" {
#  dashboard_name = "${var.tag_name}-dashboard"
#  dashboard_body = templatefile("${path.module}/../scripts/dashboard.json.tmpl", {
#    arn_cpu_alarm  = module.ec2_cw_alarm.cpu_utilization_arn
#    arn_ram_alarm  = module.ec2_cw_alarm.memory_used_percent_arn
#    arn_disk_alarm = module.ec2_cw_alarm.disk_used_percent_arn
#    aws_region     = var.region
#  })
#}
