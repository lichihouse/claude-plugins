# Crie seu App

> Nhóm: BRASIL | Jornada do Desenvolvedor / Sua trilha começa aqui! · nguồn: https://open.shopee.com/developer-guide/740

## Crie sua primeira aplicação

## Objetivo

Criar a aplicação que será responsável por se comunicar com as APIs da Shopee Open Platform.

## O que você fará nesta etapa

Você criará uma nova aplicação no Console, escolherá a categoria adequada para sua integração e configurará as informações básicas necessárias para começar o desenvolvimento em: [https://open.shopee.com/console/app](https://open.shopee.com/console/app) 

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=En2HSbPHLQqdiWnhwHf%2Bovcs%2BurGVSIGpgbSE2nulPoGhvWeTu18ww6tI%2Buk50gzYRar8PfmFAFY4METOQEqGA%3D%3D&image_type=png)

 

Nessa etapa seu aplicativo ficará "**Developing**" (Desenvolvendo), a próxima etapa é usar a API Test Tool e depois solicitar o Go-Live.

## Antes de continuar, você deve saber

- Nesse momento podem ser preenchidas informações de teste.
- Escolha a categoria do App de acordo com o objetivo da sua integração.
- Cada "App Category" possui **APIs/endpoints próprios e não há permissões manuais ou extras de outros endpoints.**
- Após criado, **não é possível alterar a categoria nem adicionar novas permissões ao mesmo App**. Caso precise acessar APIs de outra categoria, será necessário criar uma nova aplicação.
- Guarde sua Partner Key em um local seguro. Ela será utilizada para gerar a assinatura das chamadas às APIs.
- Há diferenças entre Partner Key Sandbox (enquanto o app estiver "Developing") e Live, após solicitar o Go Live, não esqueça de usar a Partner Key correta.

## Os modelos de uso mais comuns são:

Registered Business Seller: App Seller In-House System

Third-party Partner (ISV): App ERP System

## Erros comuns

- Criar um App na categoria incorreta e depois solicitar liberação de novas APIs.
- Utilizar credenciais de Sandbox em chamadas para Produção (ou vice-versa).

 
