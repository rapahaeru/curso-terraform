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

#### Variáveis

Criando uma instancia (EC2) no terraform
Navegue no Ec2, simule criar uma nova e escolha uma instancia que seja free-tier, no caso utilizaremos a máquina aws linux, e copie seu código AMI (ami-02457590d33d576c3 por exemplo).
Vá novamente na registry do terraform para procurar um [provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) de instancia ec2, procure por aws_instance e copie o trecho do resource "aws_instance"

```
resource "aws_instance" "web" {
  ami           = ami-02457590d33d576c3
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}
```

caso não tenha um default, o terraform irá pedir eses valor no momento do plan, com isso podemos administrar variáveis de ambiente em um CI através do `TF_VAR_<Variavel de ambiente> terraform plan` ou através da flag -var `terraform plan -var="aws_profile=cael-terraform"`

Pode-se criar o arquivo padrão de variáveis que o terraform lê automaticamente, chamado terraform.tfvars. Nele você adiciona todos os valores que serão setados nas variáveis de forma automática.
Mais informações para ordem de precedencia do terraform estão na [documentação](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence)

Na arquitetura de variáveis, você pode escolher qual arquivo de variáveis é o definitivo para a execução no CI, como por exemplo `terraform plan -var-file="prod.tfvars"`

após todas as modificações feitas, rode ` terraform apply -var-file="prod.tfvars" --auto-approve` e confirma se a instancia foi atualizada.

Depois disso, destrua- da mesma forma: `terraform destroy -var-file="prod.tfvars" --auto-approve`
e não esqueça de conferir na lista das instancias

#### Interpolação, locals e outputs

- [interpolação](https://developer.hashicorp.com/terraform/language/expressions/strings#interpolation)
  .. Utilizar o resource, no registry, [random_pet](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) para o nome aleatório do bucket -[Local values](https://developer.hashicorp.com/terraform/language/values/locals)
  .. serve evitar duplicidades e redundâncias. Quando uma variavel parece estar sendo utilizado em mais de um lugar, vale a pena criar um locals.
- [Output Values](https://developer.hashicorp.com/terraform/language/values/outputs)
  .. Utilizado para valores de retorno em nossa tela ou em terraform modules
  .. outputs gerado ao executar o `terraform apply` como exemplo desse commit

  ```
  bucket_arn = "arn:aws:s3:::actually-vaguely-highly-wondrous-snail-dev"
  bucket_domain_name = "actually-vaguely-highly-wondrous-snail-dev.s3.amazonaws.com"
  bucket_name = "actually-vaguely-highly-wondrous-snail-dev"
  ips_file_path = "actually-vaguely-highly-wondrous-snail-dev/config/ips.json"
  ```

#### Terraform import

Você pode importar recursos criados manualmente fora do terraform para poder assumí-lo daqui em diante e passar a gerenciar pelo terraform

- [documentação](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import) para importar o recurso do aws_s3_bucket

## Seção 04 - Terraform intermediário

### Remote state no S3

Para uso coletivo, para que todos do time tenham acesso ao state mais atualizado sempre.

Setando o backend no S3 - [documentação](https://developer.hashicorp.com/terraform/language/backend/s3#example-configuration)

O Backend é onde o arquivo terraform.tfstate será armazenado e versionado.

Aqui é necessário:

- Subir um EC2, uma instancia para qualquer tipo de manipulação de um servidor norma
- Subir um bucket separado para ter onde armazenar o remote state e todas as suas alterações
- Copiar o código do backend do link da documentação acima, dentro de `terraform {}` do _maint.tf_ do EC2.

Uma forma alternativa de montar esse backend é montar um arquivo separado com a extensão _.hcl_ e chamar no path do init: `terraform init -backend=true -backend-config="arquivo_criado.hcl"`

O conteúdo do arquivo criado deve ser o conteúdo que está no backend = {} do exemplo, no caso será:

```
    bucket  = "tf-state010438491289"
    key     = "dev/01-usando-remote-state/terraform.tfstate"
    region  = "us-east-1"
    profile = "cael-terraform"
```

### built in functions

[Link](https://developer.hashicorp.com/terraform/language/functions) da documentação

Trabalhando com:

- data (template_file, archive_file) - manipulanod conteúdo de template e também arquivos físicos para upload em um S3
- format(), lookup(), merge(), count
- variáveis dinâmicas

### Data Sources ([Doc](https://developer.hashicorp.com/terraform/language/data-sources))

- Como utilizar os Outputs no remote state
- cada recurso (resource) possui o seu data source. Na página do S3 com o resource _aws_s3_bucket_ que usamos anteriormente, possui uma seção separada chamada [Data Sources](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) com as infomrações do que é possível consultar.
- A ideia do exercício é subir um EC2 sem ter um ami definido, então buscaremos um ami via data source para poder subir o nosso EC2
- Manipulando o terraform outputs: exportando o conteúdo dos nossos outputs para um arquivo json `terraform output -json .s3/output.json`
- reestruturando as pastas para separar o s3 do Ec2. assim cada pasta seria uma espécie de projeto separado como se cada time cuidasse de um, para isso vamos consumir o remote state do outro projeto.

  [Problemas enfrentados aqui]
  Com as instruções do curso, obtive problemas de compatibilidade da arquitetura da instancia com a AMI fornecida

```
Error: creating EC2 Instance: operation error EC2: RunInstances, https response error StatusCode: 400, RequestID: 935586a3-e8a8-4b2d-ad37-bac312270310, api error InvalidParameterValue: The architecture 'x86_64' of the specified instance type does not match the architecture 'arm64' of the specified AMI. Specify an instance type and an AMI that have matching architectures, and try again. You can use 'describe-instance-types' or 'describe-images' to discover the architecture of the instance type or AMI.
```

Para isso, precisei do comando abaixo para listar todas as amis compatíveis com a arquitetura que precisava, do t3.micro:

```
 aws ec2 describe-images --filters "Name=architecture,Values=x86_64" "Name=name,Values=*ubuntu*" --owners 099720109477  --query 'Images[*].{Name:Name,ID:ImageId}' --output table --no-verify-ssl
```

E precisei substituir o `name_regex` no ec2\data.tf para um mais específico.

- agora estou conseguindo subir o arquivo instances para o Bucket S3 e ainda versionando o terraform.tfstate

### Foreach, for e splat operator

- [foreach/set](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each#basic-syntax) expressions
- [for](https://developer.hashicorp.com/terraform/language/expressions/for) expressions
- [splat](https://developer.hashicorp.com/terraform/language/expressions/splat)
