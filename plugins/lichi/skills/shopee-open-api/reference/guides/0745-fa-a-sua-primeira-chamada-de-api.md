# Faça sua primeira chamada de API

> Nhóm: BRASIL | Jornada do Desenvolvedor / Sua trilha começa aqui! · nguồn: https://open.shopee.com/developer-guide/745

# Faça sua primeira chamada de API

## Objetivo

Realizar sua primeira chamada autenticada para uma API privada da Shopee.

## O que você fará nesta etapa

Você escolherá uma API, montará a requisição, gerará a assinatura (sign) e enviará sua primeira solicitação para a Shopee utilizando uma loja já autorizada.

Acesse [V2.0 API Call Flow](https://open.shopee.com/developer-guide/27) para verificar exemplos do **fluxo de chamada de uma API.**

## Antes de continuar, você deve saber

- Cada chamada para APIs privadas precisa ser assinada utilizando sua **Partner Key**.
- O **timestamp** faz parte da assinatura e possui tempo limitado de validade.
- APIs privadas exigem **Access Token** e **Shop ID**.
- Cada endpoint possui parâmetros obrigatórios e opcionais específicos.
- O **Request ID** retornado na resposta deve ser utilizado para investigação de problemas junto ao suporte.
- Consulte sempre a **API Reference** antes de implementar um endpoint.

## Confira API Reference para obter a lista completa

- APIs
- Endpoints
- API Permission (quais Apps podem acessar aquela API)
- 📚 [https://open.shopee.com/documents/v2/v2.ams.get_open_campaign_added_product?module=127&type=1](https://open.shopee.com/documents/v2/v2.ams.get_open_campaign_added_product?module=127&type=1) 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=ytHc0pVrjGxpPowoV6DEAQTi1vStI6MKghONMIPoAbMqcOBtICvLF%2FxIWfmK2FKHgYzdk6IzRNdyo%2Bi4%2FdOAHg%3D%3D&image_type=png)

## Erros comuns

- **Wrong Sign**
  - Partner Key incorreta.
  - Timestamp expirado.
  - Assinatura calculada incorretamente.
  - URL ou parâmetros utilizados de forma diferente do cálculo da assinatura.
- **Invalid Access Token**
  - O Access Token expirou.
  - A loja ainda não foi autorizada.
  - O Access Token pertence a outra loja.
- **Permission Denied**
  - O endpoint não faz parte da categoria do App criada.

## 📚 **Leia também:**

[V2.0 Data Definition](https://V2.0%20Data%20Definition)
