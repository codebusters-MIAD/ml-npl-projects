#=======================================================================================================================
# (MANDATORY) - INPUT VARIABLES - EC2 Instance
#=======================================================================================================================

# EC2 Variables
variable "instance_type" {}
variable "ami_base_image_id" {}
variable "key_name" {}
variable "iam_instance_profile" {}
variable "subnet_id" {}
variable "vpc_security_groups" {}
variable "file_physical_path" {}
variable "ssh_user" {}
variable "template_file" {}
variable "working_directory" {}
variable "tag_name" {}
variable "environment" { type = string }
variable "region" { type = string }
variable "tags" {
  type = object({ app = string, team = string, tid = string, budget_id = string, service_id = string, function = string })
}

// Monitoring variables
variable "namespace" { default = "lazarus" }
variable "sns_topic_cw_email_notification_arn" {
  type = string
}
variable "ebs_block_device" {
  type = object({ device_name = string, volume_size = string, volume_type = string, delete_on_termination = bool})
  default = {
    device_name = "/dev/xvda"
    volume_size = "20"
    volume_type = "gp3"
    delete_on_termination = true
  }
}
