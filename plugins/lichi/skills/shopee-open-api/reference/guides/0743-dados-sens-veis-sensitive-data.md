# Dados Sensíveis (Sensitive Data)

> Nhóm: BRASIL | Jornada do Desenvolvedor / Sua trilha começa aqui! · nguồn: https://open.shopee.com/developer-guide/743

# Dados mascarados e Nota Fiscal

## Objetivo

Entender quando os dados do comprador estarão disponíveis para emissão da Nota Fiscal e como consultar essas informações pelas APIs da Shopee.

### **📌Lembrete: é necessário ter declarado IP Whitelist nos passos anteriores, dentro da sua aplicação.**

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=uKqOyMcbRP34mwhJn5BM3CXeZrwR9Wm42T%2FEegcseLJRqsRGBdAZcXF7XMmyTR4XgSweaLAXHW2ZrRUVNE3c2A%3D%3D&image_type=png)

## O que você fará nesta etapa

Você aprenderá quais dados do comprador podem ser retornados pelas APIs, em quais status do pedido essas informações ficam disponíveis e como verificar se um pedido já possui Nota Fiscal vinculada. **Para não perder possíveis atualizações, sugerimos verificar a documentação na íntegra:** [**https://open.shopee.com/developer-guide/382**](https://open.shopee.com/developer-guide/382)** **

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=kFswSlwBZWzMjBgvuY1pPg%2B1%2BypT%2FgcP3HgEWq4VhGDWlfcqLXJWOpu44rwYyftj9wovLFjXQHBh6dF87FrUGA%3D%3D&image_type=png)

 

## Antes de continuar, você deve saber

- Para vendedores **CNPJ**, a emissão da Nota Fiscal é obrigatória.
- Os dados do comprador são disponibilizados apenas quando necessários para o processo logístico e fiscal.
- Por questões de privacidade, algumas informações são mascaradas ou nunca são retornadas pelas APIs.
- O comportamento varia de acordo com o tipo de vendedor (CPF ou CNPJ) e com o status do pedido.

## Informações necessárias para emissão da Nota Fiscal ficam disponíveis APENAS nos seguintes status:

- INVOICE_PENDING
- READY_TO_SHIP
- PROCESSED
- RETURN / REFUND

## APIs afetadas

v2.order.get_order_detail  
v2.order.get_order_list

### *Confira sempre a documentação original na íntegra para não perder informações e atualizações.*

 
