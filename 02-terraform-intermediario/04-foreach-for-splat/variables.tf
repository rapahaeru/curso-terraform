
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = ""
}

variable "aws_profile" {
  type        = string
  default     = "cael-terraform" // caso não tenha um default, o terraform irá pedir eses valor no momento do plan, com isso podemos administrar variáveis de ambiente em um CI através do `TF_VAR_<Variavel de ambiente> terraform plan`
  description = ""
}