# curso-terraform

praticando curso de terraform com aws https://redarborbrasil.udemy.com/course/aws-com-terraform/

## Seção 03 - Terraform básico

#### Criação do primeiro script

No site do terraform existe uma lista de recursos que podemos criar e nesse local tem toda a documentação necessária.

[Lista de recursos](https://registry.terraform.io/browse/providers) (providers) do terraform

Estamos usando um bucket na aws, por tanto entraremos em aws e pesquisaremos _aws s3 bucket e chegamos_ no [link](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

agora copiaremos esse código de exemplo para construir o nosso main.tf.

Com o script main.tf pronto, executaremos o `terraform init` para baixar os plugins/ e gerar o arquivo do provider executável (_na pasta /terraform_)
em seguida `terraform plan` para que o terraform nos mostre o que planeja fazer, baseado no script criado.
Analisando tudo e concordando, execute o `terraform apply` e confirme para criar nosso bucket. (acesse a lista de [buckets da aws](https://us-east-1.console.aws.amazon.com/s3/home?region=us-east-1) para confirmar sua criação)

Na sequência, adicionamos o bloco terraform no script, para local a versão utilizada no curso, para evitar problemas de compatibilidade
