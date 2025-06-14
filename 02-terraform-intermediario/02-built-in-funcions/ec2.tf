resource "aws_instance" "server" {
  ami           = var.instance_ami
  instance_type = lookup(var.instance_type, var.env)
  count         = local.instance_number == 0 ? 0 : local.instance_number

  tags = merge(
    local.common_tags,
    {
      Name = format("Instance %s", count.index + 1)
      Env  = format("%s", var.env)
  })
}