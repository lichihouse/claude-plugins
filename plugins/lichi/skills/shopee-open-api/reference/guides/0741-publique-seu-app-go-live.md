# Publique seu App (Go Live)

> Nhóm: BRASIL | Jornada do Desenvolvedor / Sua trilha começa aqui! · nguồn: https://open.shopee.com/developer-guide/741

# Go Live

## Objetivo

Preparar sua aplicação para utilização em Produção, configurando as informações necessárias para aprovação e para comunicação segura com as APIs da Shopee.

## O que você fará nesta etapa

Nesta etapa você concluirá as configurações da aplicação de Produção, informará os dados necessários para validação da Shopee e configurará itens importantes como Redirect URL, IP Whitelist e declaração da infraestrutura utilizada pela sua integração

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=47MMntNIq6KlGRRQiMdguVrpNLYmprN7dXWtahO1Pe7UTX%2BrzV2P2KP%2BWitqbm92rauqXW0YS1EYhem6jK6YQQ%3D%3D&image_type=png)

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=N13Co2wchZJ87oLKTFFlYfXMnJD%2BqAZoPZGQR5s0YuWm0z3b56rXyvebnkegst0azRs5XPW3T4eqUOuVNMYu1g%3D%3D&image_type=png)

# Principais configurações da tela

## Product Brief (Descrição do Produto)

Informações utilizadas pela Shopee para entender o funcionamento da sua integração.

| Console (EN)                                                     | Português                  | Descrição                                                                    |
|------------------------------------------------------------------|----------------------------|------------------------------------------------------------------------------|
| **Please provide a live version of your business product's URL** | URL do produto em Produção | Informe a URL pública da solução utilizada pelos seus clientes.              |
| **Test Username of Business Product**                            | Usuário de teste           | Usuário para acesso ao ambiente de testes da sua solução (quando aplicável). |
| **Test Password of Business Product**                            | Senha de teste             | Senha correspondente ao usuário informado acima.                             |
| **Brief Introduction**                                           | Descrição da solução       | Explique resumidamente o que sua integração faz.                             |
| **Your client user interface screenshot**                        | Captura da interface       | Imagem da interface utilizada pelos usuários da sua solução.                 |

## Authorization Information (Informações de Autorização)

Essas configurações definem quais domínios poderão ser utilizados durante o processo de autorização da aplicação.

| Console (EN)                 | Português                    | Descrição                                                           |
|------------------------------|------------------------------|---------------------------------------------------------------------|
| **Test Redirect URL Domain** | Domínio Redirect do Sandbox  | Domínio utilizado para receber o Authorization Code durante testes. |
| **Live Redirect URL Domain** | Domínio Redirect de Produção | Domínio utilizado para receber o Authorization Code em Produção.    |

## IP Address Whitelist (Lista de IPs Permitidos)

Permite informar quais servidores poderão realizar chamadas às APIs da Shopee.

| Console (EN)                    | Português                         | Descrição                                                                               |
|---------------------------------|-----------------------------------|-----------------------------------------------------------------------------------------|
| **APP IP Address Management**   | Gerenciamento de IPs da Aplicação | Informe um endereço IP por linha correspondente aos servidores da sua integração.       |
| **Enable IP Address Whitelist** | Habilitar lista de IPs            | Ativa a validação para que somente os IPs cadastrados possam realizar chamadas às APIs. |

# Other IT Assets Declaration (Declaração da Infraestrutura)

Informe informações sobre a infraestrutura utilizada pela sua aplicação.

| Console (EN)         | Português                    | Descrição                                                                         |
|----------------------|------------------------------|-----------------------------------------------------------------------------------|
| **Database Servers** | Servidores de Banco de Dados | Informe os IPs dos servidores de banco de dados utilizados pela solução.          |
| **Other Servers**    | Outros Servidores            | Informe os IPs de outros servidores utilizados pela integração, quando aplicável. |

## Antes de continuar, você deve saber

- A Shopee poderá validar as informações da sua integração antes da aprovação do ambiente de Produção.
- **Algumas APIs (como a API Order - dados do comprador) retornam informações consideradas Sensitive Data (dados sensíveis)**.
- Para acessar esses dados, é necessário declarar corretamente os IPs utilizados pela sua integração e **habilitar o IP Address Whitelist**.
- Caso essa configuração não seja realizada corretamente, sua aplicação poderá apresentar o aviso **Sensitive Data** no Console e determinados campos serão retornados mascarados.
- Documentação completa disponível em [Requesting Access to Sensitive Data](https://open.shopee.com/developer-guide/718)

## Próximo passo

Agora você está pronto para autorizar uma loja e obter seu primeiro **Access Token**.

📚 Siga para o próximo passo em [Autorização e Autenticação](https://open.shopee.com/developer-guide/739)

 

 
