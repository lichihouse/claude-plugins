# Autorize sua primeira loja

> Nhóm: BRASIL | Jornada do Desenvolvedor / Sua trilha começa aqui! · nguồn: https://open.shopee.com/developer-guide/739

## Objetivo

 

Na Shopee, para que um App (criado no Open Platform Console) possa ter acesso aos dados de uma loja pela API, é preciso que ela dê autorização à esse App.  
Para isso, crie um link de autorização seguindo as regras abaixo, forneça ele ao vendedor e oriente ele a autorizar.

## O que você fará nesta etapa

Apenas aplicativos como tipo Seller In-House System possuem o botão "Authorize" direto no console, demais aplicativos precisam gerar a REDIRECT URL, que deve ser construída pelo desenvolvedor, seguindo os parâmetros e path da Shopee. Confira sempre a documentação de Autorização e Autenticação na íntegra, para verificar as informações de forma atualizada. (Obs: mude o console para Português para ler as documentações traduzidas).

## Fluxo para APP: Seller In-House System

O processo é inciado **dentro do console, no botão Authorize**. Ao clicar em Authorize aparecerá uma tela para confirmar a REDIRECT URL, que já foi cadastrada na hora da **criação** do app. Se atualizar a URL nesse momento e tentar a autorização, retornará erro: {"code":1,"error":"error_param","msg":"The domain of redirect_uri is not consistent with the Redirect URL Domain declared in console.","debug_message":""}

 

Portanto, a URL de autorização cadastrada dentro dos detalhes do aplicativo e a URL de autorização no campo "Redirect URL", devem ser a mesma.

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=CKeBkSsR6OzgXtoiVqHeVUoSHd2pPnjJEbpkQpoXcr1sfVHvIpzQtUvaQrSdYpDNuO1Y9rCOguH%2FIPjTbshV0Q%3D%3D&image_type=png)

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=WCQyQESE0CwHoe3S4B%2B6aHEDEyQ7A1PJMdoB8CceJMEzahJpqvf%2FgVKDtDMZQiNIit9JZtpOqmaSWQx5gGBoeA%3D%3D&image_type=png)

## Fluxo para APP: ERP System

Esse tipo de aplicativo **não possui o botão Authorize no console**, pois ERP System funciona para aprovar lojas terceiras e não lojas próprias. Portanto, devem seguir o fluxo de autorização, com a URL já cadastrada dentro dos detalhes do aplicativo, disponibilizando essa URL numa interface, para acesso do vendedor que pretende autorizar a integração da loja com o aplicativo do parceiro.

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=dQNDbu4APIUpn%2FbAPwgvydboF0traexCbpgs5Lh%2BvlZZxnVQ5V1Jf45TuzGBlIyuqPxrzUgiERpTbAvX6kTawg%3D%3D&image_type=png)

## Documentação a seguirem:

Autorização e Autenticação: [https://open.shopee.com/developer-guide/20](https://open.shopee.com/developer-guide/20) 

### (Sempre orientamos a documentação na íntegra, para verificar URL e parâmetros técnicos de forma atualizada).

## **Antes de continuar, você deve saber**

- O desenvolvedor é responsável por gerar a URL de autorização.
- O vendedor é quem acessa essa URL e autoriza a aplicação.
- Se o desenvolvedor é o próprio vendedor, o processo é iniciado por dentro do console, no botão Authorize.
- O vendedor consegue autorizar o acesso do aplicativo a loja por, no máximo, 365 dias. Após 365 a conexão **irá expirar e as APIs não irão funcionar**. Necessário realizar o processo de autorização novamente.
