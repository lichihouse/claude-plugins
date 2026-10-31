# Perguntas Frequentes

> Nhóm: BRASIL | Jornada do Desenvolvedor / Sua trilha começa aqui! · nguồn: https://open.shopee.com/developer-guide/735

### Após criação do seu login e a aprovação do perfil de desenvolvedor (Third-Party Partner ou Registered Business Seller), é de responsabilidade do desenvolvedor acompanhar e seguir integralmente a documentação oficial da Shopee Open Platform:

 

Confirma abaixo os principais tópicos de dúvidas sobre os passos inciais de desenvolvimento:

***- Criação e Permissões de Aplicativos (Apps)***

***- Autorização de loja***  
***- App de Chat***  
***- IP Whitelist/Sensitive Data/Mascaramento de Dados***  
***- Sandbox***  
***- Autorização e Autenticação***  
***- Partner Key e Reset***

## 1. Permissões, APIs e Categoria do Aplicativo

  
A categoria selecionada durante a criação do aplicativo é o fator que determina todas as capacidades e limitações da integração, incluindo APIs e endpoints permitidos.  
Portanto, não existem liberações adicionais ou concessões de permissões extras. Erros como "This app type has no permission to this API" são resolvidos conferindo a categoria do APP.  
 

Documentação:  
[**App management**](https://open.shopee.com/developer-guide/14)

[**\[BR\] Criação de App: permissões e APIs são definidas pela categoria selecionada**](https://open.shopee.com/announcements/1400?category=3&is_top=false)

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=Djq9OKo2i%2Ben%2B7GSu3B1nDTmpNu0aMgdujmRL2IPd1FwpZBJQCY4JLJON%2BspgK7o%2Btnc%2BKKn60SA27puQWybKQ%3D%3D&image_type=png)

## **2. Customer Service (Chat API)**

  
Conforme política global da Shopee Open Platform, novas solicitações para aplicativos da categoria Customer Service de desenvolvedores independentes e plataformas **Third-party Partner foram encerradas** em *18 de novembro de 2024*. (Applications for Customer Service Apps from Individual Third Parties and Third-party Partner Platforms have been closed since November 18, 2024.)

  
[**\[BR\] Lembrete: Política de Acesso à Chat API (Chat API)**](https://open.shopee.com/announcements/1430)

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=snKy8ZATDXsU3BRona54qvgzxmXoSBSnQQBOSlNcRquPQFqvKXwPAVL%2FCRBpRd9GDFjfrd80An%2FslndR6bqHwQ%3D%3D&image_type=png)

### Atenção: O time de Open Platform não possui visão sobre RMs de cada conta, contate o Atendimento ao Vendedor, se não tiver RM, não é possível prosseguir.

##  3. I**P Whitelist/Sensitive Data/Mascaramento de Dados**

  
O mascaramento de dados e acesso a dados sensíveis está diretamente relacionado às configurações de segurança da aplicação, como IP Whitelist.  
Todo o processo de configuração deve ser realizado pelo próprio desenvolvedor dentro do aplicativo.   
  
[Requesting Access to Sensitive Data - How to Enable IP Address Whitelisting](https://open.shopee.com/developer-guide/718)  
[**Lembrete: Acesso a Dados Sensíveis (Sensitive Data Access)**](https://open.shopee.com/announcements/1364)  
[https://open.shopee.com/announcements/1364](https://open.shopee.com/announcements/1364)  
  
Além disso, existem cenários e status específicos em que os dados do comprador não serão disponibilizados pela API, conforme documentado em: [**Passo a passo para subir a NF-e através da OpenAP**](https://open.shopee.com/developer-guide/382%C2%A0)

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=OrCFitjfe4Z0nfLPzmxxTBMLSru0uBQiCD4hyvAQG3dRbb5Z2vZtF53HcrTL9JjrzYpyZYCwXbPabqPzwyB8Cw%3D%3D&image_type=png)

## **4. Sandbox (test.stable = ambiente de teste)**

  
O ambiente Sandbox (test-stable) é destinado exclusivamente para testes e validações de integração. Embora seja funcional, ele não replica integralmente o ambiente de produção e, portanto, comportamentos divergentes, limitações e instabilidades podem ocorrer.  
  
[**Sandbox Testing V2**](https://open.shopee.com/developer-guide/644)

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=ox30IEKwGgxr65Uz9hGsYlQvGmK0Ixf32inBSszlJhSfaVmi0kh9%2FJGvkGkenVyQdll7vZCSwnyPIdbJ8WxuGA%3D%3D&image_type=png)

## **5. Autorização e Autenticação**

  
Existem 3 etapas para concluir a autorização: gerar o link de autorização, obter autorização da(s) loja(s) e obter/renovar o access_token. Sigam a documentação oficial para utilizar as URLs e caminhos corretos e atualizados.  
  
[**Authorization and Authentication**](https://open.shopee.com/developer-guide/20)

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=nh7jsMCs4gqVS6rEVFPMtjvtFBPfRjdh5d3tdZlVn0MT9DzUM2EbqOPLBjnhG%2BcNEb0EwaVhdKEpcFXxhq%2FWPw%3D%3D&image_type=png)

## 6. **Partner Key e Reset da Partner Key**  

Para melhorar ainda mais a segurança e flexibilidade da gestão de partner keys da Open API e reduzir o risco de interrupções no serviço, a Shopee otimizou o processo de reset da Partner Key. Configura as mudanças diretamente na documentação para não perder atualizações. Anúncio: [\[Importante\] Melhorias no reset da Open API Partner Key](https://open.shopee.com/announcements/1192)  
  
A partner key é configurada e reseta dentro do APP, em [*APP LIST*](https://open.shopee.com/console/app) no Console.

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=XqqUNKZbPBQZZ%2BJMIlQddAlxj8VQzVmS3o9CFpjzvwPVSLPL760yUe7yq8%2F%2BViY7vcNPiX25a98fu4s57WMwzA%3D%3D&image_type=png)

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=jrznP9Qy7aTT46gvco2JWIZjCgMCSwx6R%2F3kOY6TtWax7rXA1FVf19eiMCB2n4YnVM2Y2YnjFoBk5mwx%2Ba5Zng%3D%3D&image_type=png)

 

Antes de abrir um ticket  
Verifique primeiro:  
- A documentação oficial.  
- A API Reference.  
- Os Announcements.  
- Se o endpoint ainda existe.  
- Se o fluxo seguido está correto.  
- Se sua aplicação possui a permissão necessária (pela categoria do app).  
- Se o comportamento já não está documentado.  
- Utilize a Assistente IA.  
 
