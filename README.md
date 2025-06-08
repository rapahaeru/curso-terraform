# curso-terraform

praticando curso de terraform com aws https://redarborbrasil.udemy.com/course/aws-com-terraform/

## Seção 03 - Terraform básico

#### Criação do primeiro script

No site do terraform existe uma lista de recursos que podemos criar e nesse local tem toda a documentação necessária.

[Lista de recursos](https://registry.terraform.io/browse/providers) (providers) do terraform

Estamos usando um bucket na aws, por tanto entraremos em aws e pesquisaremos _aws s3 bucket e chegamos_ no [link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

agora copiaremos esse código de exemplo para construir o nosso main.tf.

Com o script main.tf pronto, executaremos o `terraform init` para baixar os plugins/ e gerar o arquivo do provider executável (_na pasta /.terraform_)
em seguida `terraform plan` para que o terraform nos mostre o que planeja fazer, baseado no script criado.
Analisando tudo e concordando, execute o `terraform apply` e confirme para criar nosso bucket. (acesse a lista de [buckets da aws](https://us-east-1.console.aws.amazon.com/s3/home?region=us-east-1) para confirmar sua criação)

Na sequência, adicionamos o bloco terraform no script, para local a versão utilizada no curso, para evitar problemas de compatibilidade

#### Testando alterar e destruir

Para qualquer atualização no código, posterir a isso, utilizamos o `terraform validate` para confirmar se as alterações são válidas e de acordo com as especificações.
Outro comando interessante é o `terraform fmt` para formatar o código deixando no padrão que o terraform recomenda.

após utilizar o `terraform validate` recebi um erro por conta da versão antiga do curso e pelo comando _required_version_ na versão 0.14.4, portanto seguirei o curso com as versões mais atualizadas

resposta do erro:

```
C:\user\dev\curso-terraform\01-primeiro-script> terraform validate
╷
│ Error: Unsupported Terraform Core version
│
│   on main.tf line 2, in terraform:
│    2:     required_version = "0.14.4"
│
│ This configuration does not support Terraform version 1.12.1. To proceed, either choose another supported Terraform version or update
│ this version constraint. Version constraints are normally set for good reason, so updating the constraint may lead to other errors or
│ unexpected behavior.
```

na sequência chamarei o `terraform plan` só que agora com o argumento de saída para um arquivo físico chamado tfplan.out, o comando fica assim `terraform plan -out="tfplan.out"`. Com isso o terraform irá escrever todo o código de saída nesse arquivo, com isso, na hora de executar o apply, eu uso nesse arquivo.

esse será o plan demostrado no shell, onde o sinal de `~` são os campos atualizados

```
  ~ resource "aws_s3_bucket" "rapahaeru-test-bucket" {
        id                          = "rapahaeru-test-bucket-0005220"
      ~ tags                        = {
            "Environment" = "Dev"
            "Managedby"   = "Terraform"
          ~ "Name"        = "rapahaeru bucket" -> "rapahaeru test bucket"
          + "updatedBy"   = "2025-06/07"
        }
      ~ tags_all                    = {
          ~ "Name"        = "rapahaeru bucket" -> "rapahaeru test bucket"
          + "updatedBy"   = "2025-06/07"
            # (2 unchanged elements hidden)
        }
        # (12 unchanged attributes hidden)

        # (3 unchanged blocks hidden)
    }
```

na sequencia, execute o comando `terraform apply "tfplan.out"` como ele sugere, para que as alterações sejam exexutadas no bucket da aws.

No caso de renomear o bucket, o plan do terraform irá nos informar que esse bucket precisará ser destruído para a criação de um novo.

Agora para destruir definitivamente, é executar o `terraform destroy` e o recurso será destruído na aws
