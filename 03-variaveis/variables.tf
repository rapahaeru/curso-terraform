variable "enviroment" {
  type = string
  #   default     = "dev"
  description = ""
}


variable "aws_region" {
  type = string
  #   default     = "us-east-1"
  description = ""
}

variable "aws_profile" {
  type = string
  #   default     = "cael-terraform" // caso não tenha um default, o terraform irá pedir eses valor no momento do plan, com isso podemos administrar variáveis de ambiente em um CI através do `TF_VAR_<Variavel de ambiente> terraform plan`
  description = ""
}

variable "aws_instance_ami" {
  type = string
  #   default     = "ami-02457590d33d576c3"
  description = ""
}

variable "aws_instance_type" {
  type = string
  #   default     = "t3.micro"
  description = ""
}

variable "aws_instance_tags" {
  type = map(string)
  #   default = {
  #     Name    = "Linux"
  #     Project = "curso aws com terraform"
  #   }
  description = ""
}



