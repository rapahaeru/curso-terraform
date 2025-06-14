
variable "env" {}

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

variable "instance_ami" {

  default     = "ami-09e6f87a47903347c"
  type        = string
  description = ""

  validation {
    condition     = length(var.instance_ami) > 4 && substr(var.instance_ami, 0, 4) == "ami-"
    error_message = "instancia deve ser um AMI válido, começando com ami-"
  }
}

variable "instance_number" {
  type = object(
    {
      dev  = number
      prod = number
    }
  )

  description = "número de instancias a serem criadas"

  default = {
    dev  = 1
    prod = 3
  }
}

variable "instance_type" {
  type = object({
    dev  = string
    prod = string
  })
  description = ""

  default = {
    dev  = "t2.micro"
    prod = "t3.micro"
  }
}