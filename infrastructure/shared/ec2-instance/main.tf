#=======================================================================================================================
# AWS EC2 MODULE
#=======================================================================================================================
locals {
  source_path     = "../../../server"
  cw_agent_script = "../shared/scripts/cw-agent.sh"
}

resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_base_image_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = false
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_groups
  ebs_optimized               = false

  ebs_block_device {
    device_name = var.ebs_block_device.device_name
    volume_size = var.ebs_block_device.volume_size
    volume_type = var.ebs_block_device.volume_type
    delete_on_termination = var.ebs_block_device.delete_on_termination
    tags = {
      Name        = "${var.tag_name}-ec2-block-device"
      App         = var.tags.app
      TID         = var.tags.tid
      BUDGETID    = var.tags.budget_id
      SERVICEID   = var.tags.service_id
      ENVIRONMENT = var.environment
      FUNCTION    = var.tags.function
    }
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes        = [user_data, tags["CREATED_BY"], tags["CREATED_DATE"], tags["map-migrated"],
      tags_all["CREATED_BY"], tags_all["CREATED_DATE"], tags_all["map-migrated"]]
  }

  tags = {
    Name        = var.tag_name
    App         = var.tags.app
    TID         = var.tags.tid
    BUDGETID    = var.tags.budget_id
    SERVICEID   = var.tags.service_id
    ENVIRONMENT = var.environment
    FUNCTION    = var.tags.function
  }

  user_data = var.template_file

  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = self.private_ip
    private_key = file(var.file_physical_path)
  }

  #TODO improve the way to set these provisioners to avoid hardcode them in the module, this should be dynamically
  provisioner "file" {
    source      = "${local.source_path}/package.json"
    destination = "${var.working_directory}/package.json"
  }

  provisioner "file" {
    source      = "${local.source_path}/package-lock.json"
    destination = "${var.working_directory}/package-lock.json"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir ${var.working_directory}/src"
    ]
  }

  provisioner "file" {
    source      = "${local.source_path}/src/"
    destination = "${var.working_directory}/src"
  }

  provisioner "file" {
    source      = "${local.source_path}/server.js"
    destination = "${var.working_directory}/server.js"
  }

  provisioner "file" {
    source      = local.cw_agent_script
    destination = "${var.working_directory}/cw-agent.sh"
  }
}
