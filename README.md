# Cadê Buffet?

## Desenvolvedora

[Sara Ikeda](https://github.com/Sara-Ikeda)

### Sumário
🏷️ [Descrição](#descrição)

🏷️ [Funcionalidades](#funcionalidades)

🏷️ [Como Executar a Aplicação](#como_executar_a_aplicação)

🏷️ [SEEDS](#seeds)

🏷️ [CRUD](#crud)


## Descrição

Projeto Crash Course do TreinaDev da Campus Code: desenvolver uma aplicação web com [Ruby on Rails](https://guides.rubyonrails.org/) simulando catálogo de Buffets.

## Funcionalidades

✅ Listagem de Buffets.

✅ Na página de detalhes de um Buffet: detalhes dos tipos de eventos oferecidos e seus respectivos preços-base.

✅ Campo para buscar Buffet: pelo nome fantasia, pela cidade ou pelos tipos de eventos.

✅ Criar conta como Donos de Buffet. Estes, podendo cadastrar seu Buffet, tipos de eventos e preços-base.

✅ Criar conta como Clientes. Estes, podendo fazer um pedido para um Buffet.

✅ APIs de Buffets e tipos de eventos - veja como consumi-lá na [documentação](/README_API.md).

## Como Executar a Aplicação

No terminal, clone o projeto:

```
git clone https://github.com/Sara-Ikeda/projeto_cade_buffet.git
```
Entre na nova pasta do projeto:

```
cd projeto_cade_buffet
```

Instale as dependencias:

```
bundle install
```

Execute a aplicação:

```
rails server
```

Assim a aplicação pode ser acessada a partir da rota http://localhost:3000/

## SEEDS

Sendo um ambiente de desenvolvimento e teste, foi utilizado _seeds_ para adicionar dados iniciais no banco de dados.

### Donos de Buffet:

|Email|Senha|
|-------------------|----------|
| buffet1@email.com | password |
| buffet2@email.com | password |
| buffet3@email.com | password |

### Buffets:
|Dono|Nome Fantasia|Cidade/UF|
|----|-------------|---------|
| buffet1| Gourmet dos Noivos |São Paulo/SP|
| buffet2 | Doces e Salgados SP |São Paulo/SP|
| buffet3 | Doces do RJ |Niterói/RJ|

### Tipos de Evento:
|Buffet|Nome|
|------|----|
|Gourmet dos Noivos|Festa de Casamento|
|Gourmet dos Noivos |Festa de Bodas|
|Doces e Salgados SP|Festa de Aniversário|
|Doces do RJ|- _Não Cadastrado_ -|

### Clientes:
|Nome|Email|Senha|
|---------|-------------------|----------|
|Cliente 1| client1@email.com | password |
|Cliente 1| client2@email.com | password |
|Cliente 1| client3@email.com | password |

### Pedidos:
|Cliente|Buffet|Tipo de Evento|Status|
|-------|------|--------------|------|
|Cliente 1|Gourmet dos Noivos|Festa de Casamento|Confirmado|
|Cliente 1|Doces e Salgados SP|Festa de Aniversário|Aguardando Avaliação|
|Cliente 2|Gourmet dos Noivos |Festa de Bodas|Aprovado|
|Cliente 3|Doces e Salgados SP|Festa de Aniversário|Cancelado|


Rode o comando abaixo no terminal para derrubar o banco de dados, criá-lo e popular com os dados dos seeds:
```
rails db:reset
```


## CRUD

### Donos de Buffet
☑️ Pode se cadastrar na página de _Criar Conta como Donos de Buffet_ a partir de um formulário fornecendo email e senha.

### Buffets
☑️ Devem ser criados após o cadastro da conta de Dono, não sendo possível acessar outra página.

☑️ São listados na página inicial da aplicação para visitantes e clientes, apenas com nome fantasia e cidade/UF.

☑️ Mais detalhes são acessados pelo nome fantasia.

☑️ Podem ser editados apenas por seus donos.

☑️ Não podem ser excluídos.


### Tipos de Evento
☑️ Podem ser criados pelo dono do Buffet na página do mesmo.

☑️ São listados na página de detalhes de seus respectivos Buffets. São mostrados todos os detalhes.

☑️ Podem ser editados apenas por seus donos.

☑️ Não podem ser excluídos.

### Preços-base dos Eventos
☑️ Podem ser criados até dois pelo dono do Buffet na página do mesmo, logo à baixo de seu respectivo tipo de evento.

☑️ São listados na página de detalhes dos Buffets à baixo de seus respectivos tipos de evento. São mostrados todos os detalhes.

☑️ Podem ser editados apenas por seus donos.

☑️ Não podem ser excluídos.

### Clientes
☑️ Pode se cadastrar na página de _Criar Conta como Cliente_ a partir de um formulário fornecendo nome, CPF, email e senha.

### Pedidos
☑️ Podem ser criados pelos Clientes na páginas de detalhes dos Buffets, logo após os preços-base.

☑️ São listados na página Pedidos apenas com seus códigos. Donos de Buffets veem todos os pedidos feitos para seu Buffet. E Clientes veem todos os seus pedidos feitos.

☑️ Mais detalhes são acessados pelo código único.

☑️ Não podem ser editados nem excluídos.

### Orçamentos de Pedido
☑️ São criados quando Donos e Buffets aprovam pedidos.

☑️ Seus detalhes são listados para os Clientes na página de detalhes do pedido.

☑️ Não podem ser editados nem excluídos.