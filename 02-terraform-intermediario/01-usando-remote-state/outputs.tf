output "EC2_info" {
  value = aws_instance.this.ami
}

output "EC2_instance_type" {
  value = aws_instance.this.instance_type
}

output "EC2_name" {
  value = aws_instance.this.tags.name
}