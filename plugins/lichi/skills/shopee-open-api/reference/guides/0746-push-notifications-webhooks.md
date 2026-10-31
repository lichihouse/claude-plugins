# Push Notifications (Webhooks)

> Nhóm: BRASIL | Jornada do Desenvolvedor / Sua trilha começa aqui! · nguồn: https://open.shopee.com/developer-guide/746

# Configure Push Notifications

## O que são Push Notifications?

Push Notifications são mensagens enviadas pela Shopee diretamente para a Callback URL configurada pela sua aplicação quando ocorre um evento relevante.

Por exemplo:

- Um pedido foi criado;
- O status de um pedido foi alterado;
- Um produto foi atualizado;
- Uma autorização foi cancelada;
- Uma atualização logística ocorreu.

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=yHs8IMFOPm%2Bus2dqYTQwa95cRkYvrf88lmxTgKUnZL4W6562LoIl9GdD09btWDLLXICB4HNIydt9IBB8rzF9oA%3D%3D&image_type=png)

## Objetivo

Permitir que a Shopee envie atualizações automaticamente para sua integração quando determinados eventos ocorrerem, sem que sua aplicação precise consultar as APIs repetidamente.

## O que você fará nesta etapa

Você configurará uma **Callback URL**, selecionará os eventos que sua aplicação precisa receber e preparará seu sistema para processar as notificações enviadas pela Shopee.

## Antes de continuar você precisa saber:

- No Shopee Open Platform, Push Mechanism é o mesmo conceito conhecido como Webhook em outras plataformas.
- Push NÃO substitui API. O Push só diz: "Algo mudou." Depois disso o desenvolvedor chama a API correspondente.
- Nem todo App possui todos os Push. Verifique os webhooks disponíveis na documentação.
- Callback URL precisa ser verificada. A Shopee faz um POST para validar a URL.
- Cada Push enviado pela Shopee contém um **Authorization Header**, que pode ser validado utilizando sua Partner Key para confirmar que a requisição realmente foi enviada pela Shopee.
- Callback deve responder 2xx.
- **Consulte a documentação para obter detalhes sobre a lógica de reenvio das notificações (*****Push Mechanism Retry Logic*****) e sobre os critérios de aviso e desabilitação automática do Push Mechanism (*****Push Mechanism Warning/Disable Logic*****).**

## Como configurar

1.  Acesse o **Open Platform Console**.
2.  No menu lateral, clique em **Push Mechanism**.
3.  Selecione a aplicação que deseja configurar.
4.  Informe a **Callback URL** da sua integração.
5.  Selecione ou habilite os eventos necessários.
6.  Realize a validação solicitada pelo Console.
7.  Salve a configuração.
8.  Confirme que sua aplicação consegue receber e processar os eventos.

 

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=csEtOLWHUlEnBCVI8Wr7RCFfyA78x%2F6gmUpFLLSZCgNWipCvHpIi%2Bj7SZcqj1fa1pDaYJsraHQDhksqP1d2N7Q%3D%3D&image_type=png)

No Sandbox V2, é possível configurar a **Test Callback URL**, concluir sua validação e utilizar a opção **Push Test Data** para enviar dados de teste à aplicação. O Push de Sandbox é independente da configuração de Produção.

## Próximo passo

Após configurar Push Notifications, monitore o recebimento dos eventos e valide se sua aplicação está atualizando corretamente pedidos, produtos e demais recursos relacionados.

 

 

📚 **Leia a documentação completa**

- [Push Mechanism notifications](https://open.shopee.com/developer-guide/18)
- [Push APIs List](https://open.shopee.com/push-mechanism/5)

![](https://open.shopee.com/opservice/api/v1/image/download/?image_id=5zxDde5qy9S9dGRuqCktoYpAxAE33SUn2FvN3D8xHKTTcKqAj8Df3JyxeUisQGNgKdNHnRgM9dvEPUwgwwUylQ%3D%3D&image_type=png)
