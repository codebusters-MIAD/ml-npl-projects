output "ec2_instance_id" {
  description = "AWS ec2 instance id"
  value       = aws_instance.ec2_instance.id
}