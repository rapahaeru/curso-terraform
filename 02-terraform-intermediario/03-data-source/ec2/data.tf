data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true
  #name_regex  = "ubuntu"
  name_regex = "^ubuntu/images/hvm-ssd/ubuntu-.*-amd64-server-.*"
}