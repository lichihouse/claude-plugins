# Boas práticas antes de abrir um ticket

> Nhóm: BRASIL | Jornada do Desenvolvedor / Sua trilha começa aqui! · nguồn: https://open.shopee.com/developer-guide/747

# Boas práticas antes de abrir um ticket

Para agilizar a investigação e reduzir o tempo de resolução, envie sempre as evidências técnicas necessárias, de acordo com o tipo de problema.

## Erros em chamadas de API

Sempre envie:

- Endpoint utilizado;
- Request completo;;
- Response completo;
- Request ID;
- Data e horário da requisição;
- Evidências geradas nas **últimas 24 horas**.

**Importante:** Tickets sem Request ID ou com evidências antigas podem não ser passíveis de investigação.

## Erros no fluxo de autorização da loja (Authorization / OAuth)

Sempre envie:

- Vídeo completo do fluxo, desde o início até o erro;
- Arquivo HAR da tentativa;
- URL de autorização utilizada;
- Partner ID;
- Ambiente (Sandbox ou Produção);
- Data e horário da tentativa;
- Número de telefone ou e-mail utilizado para realizar o login (pode ser mascarado);
- Mensagem de erro apresentada.

Não é necessário enviar Request ID caso o erro ocorra antes da chamada da API get_access_token.

## Erros relacionados ao OTP (código de verificação)

Sempre envie:

- Vídeo completo da tentativa;
- Arquivo HAR;
- Número de telefone (ou e-mail, quando aplicável) utilizado para receber o código;
- Data e horário da tentativa;
- Mensagem de erro apresentada;
- Ambiente (Sandbox ou Produção).

## Erros durante a obtenção do Access Token

Além das evidências acima, envie também:

- URL completa de redirecionamento recebida após a autorização;
- Request completo para v2.public.get_access_token;
- Response completo;
- Request ID;
- Data e horário da requisição.

## Erros relacionados a Webhooks / Push Notifications

Sempre envie:

- URL do Callback;
- Evento configurado;
- Request recebido (Headers e Body);
- Response retornado pelo servidor;
- Código HTTP retornado;
- Data e horário da ocorrência;
- Request ID (quando disponível).

## Erros relacionados a Upload de Arquivos ou Imagens

Sempre envie:

- Endpoint utilizado;
- Request completo;
- Response completo;
- Request ID;
- Arquivo utilizado no teste (quando possível);
- URL retornada pelo upload (quando aplicável);
- Data e horário da tentativa.

## Antes de abrir um ticket

Verifique se:

- A documentação da API foi consultada;
- O endpoint pertence à categoria do seu aplicativo;
- O aplicativo possui as permissões necessárias;
- O Access Token está válido;
- A assinatura (Sign) foi gerada corretamente;
- O horário do servidor está sincronizado;
- O problema foi reproduzido recentemente (últimas 24 horas).

 

### ***Quanto mais completas forem as evidências enviadas, mais rápida será a investigação. Em muitos casos, a ausência de informações essenciais impede a análise técnica e pode resultar na solicitação de novas evidências antes do início da investigação.***
