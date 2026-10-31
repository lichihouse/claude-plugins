# Declare seus IPs

> Nhóm:  · nguồn: https://open.shopee.com/developer-guide/742

## Objetivo

Configurar sua aplicação para acessar dados sensíveis retornados por determinadas APIs da Shopee, quando sua integração realmente precisar dessas informações.

## O que você fará nesta etapa

Você verificará se sua integração necessita acessar dados sensíveis, declarará os servidores utilizados pela aplicação e habilitará o **IP Address Whitelist** no Console.

Em alguns países e perfis de desenvolvedor, também poderá ser necessário enviar um **Penetration Test Report** para aprovação da Shopee.

## Antes de continuar, você deve saber

- Por padrão, informações sensíveis são retornadas mascaradas pelas APIs.
- **Dados como nome, telefone, e-mail e endereço são considerados Sensitive Data.**
- Nem todas as integrações precisam solicitar acesso a esses dados.
- Para todos os desenvolvedores, é obrigatório declarar os IPs da aplicação e habilitar o **IP Address Whitelist**.
- Desenvolvedores Third-party Partner (ISV) de alguns mercados também precisam enviar um **Penetration Test Report**.

# Quando preciso configurar Sensitive Data?

Você provavelmente precisará realizar essa configuração quando sua integração necessitar acessar informações pessoais dos compradores retornadas pelas APIs.

Caso contrário, os campos poderão ser retornados mascarados ou indisponíveis.

# Como habilitar o acesso?

1.  Acesse **App List**.
2.  Selecione sua aplicação.
3.  Clique em **Go Live ou em Edit, se já estiver em produção**.
4.  Localize a seção **IP Address Whitelist**.
5.  Informe os IPs dos servidores utilizados pela aplicação.
6.  Ative **Enable IP Address Whitelist**.
7.  Clique em **Submit**.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=dprvnS8OcxBcYGSgy%2Fl4V%2F4ad1pzOmm32pTeJBkpU%2FCRKb%2BeKRmL8OhFoI2H36Tppyx9Fbuxeq3tY1QzSoSnSA%3D%3D&image_type=png)

## Importante

Após habilitar o **IP Address Whitelist**, apenas os IPs declarados poderão realizar chamadas às APIs da Shopee.

Caso sua infraestrutura seja alterada, será necessário atualizar os IPs cadastrados.

## 📚Leia a documentação completa

- [**Requesting Access to Sensitive Data**](https://open.shopee.com/developer-guide/718)
