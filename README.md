# Documentação API

API acessível via requisições HTTP e com retornos em formato JSON.

## Buffets

Lista dos buffets cadastrados na aplicação.

### 1. Listagem com todos os Buffets

__Requisição:__ `GET /api/v1/buffets`

#### Respostas

|Status|                               |
|------|-------------------------------|
| 200  | listagem completa dos buffets |
| 204  | não há buffets cadastrados    |
| 500  | erro do servidor              |


_Exemplo de JSON da resposta 200:_
```
[
  {
    "id":1,
    "trade_name":"Gourmet dos Noivos",
    "contact":"55961524798 | noivos@contato.com"
  },
  {
    "id":2,
    "trade_name":"Doces & Salgados SP",
    "contact":"55985943684 | sac@docesesalgados.com"
  }
]
```

* `id` : O _ID_ do buffet para futura consulta.
* `trade_name` : Nome Fantasia (público) do buffet.
* `contact` : Telefone e E-mail de contato.

### 2. Filtro de busca

__Requisição:__ `GET /api/v1/buffets?search=value`

Subistituindo _value_ por um nome (podendo ser parcial) de buffet, é retornado os buffets com nomes fantasia correspondentes.

#### Respostas

|Status|                                         |
|------|-----------------------------------------|
| 200  | lista dos buffets resultante da busca   |
| 204  | nenhum buffet correspondente encontrado |
| 500  | erro do servidor                        |


_Considerando o exemplo anterior, a requisição `GET /api/v1/buffets?search=Doces` resultaria no JSON:_
```
[
  {
    "id":2,
    "trade_name":"Doces & Salgados SP",
    "contact":"55985943684 | sac@docesesalgados.com"
  }
]
```
### 3. Detalhes de um buffet

Requisição: `GET /api/v1/buffets/id`

A partir do _ID_ de um buffet, retorna os detalhes do buffet.

#### Respostas

|Status|                                               |
|------|-----------------------------------------------|
| 200  | detalhes disponíveis do buffet correspondente |
| 404  | ID fornecido não é de um buffet cadastrado    |
| 500  | erro do servidor                              |


_Ainda considerando o primeiro exemplo, a requisição `GET /api/v1/buffets/1` retornaria:_
```
{
  "id":1,
  "trade_name":"Gourmet dos Noivos",
  "telephone":"55961524798",
  "email":"noivos@contato.com",
  "description":"Buffet especializado em casamento",
  "payment_types":"Cartão Débito/Crédito",
  "address":
    {"
      street":"Av Paulista",
      "number":50,
      "district":"Bela Vista",
      "city":"São Paulo",
      "state":"SP",
      "zip":"01153000"
    }
}
```

* `id` : _ID_ do buffet.
* `trade_name` : Nome Fantasia (público).
* `telephone` : Telefone para contato.
* `email` : E-mail para contato.
* `description` : Descrição.
* `payment_types` : Meios de pagamento aceitos.
* `address` : Endereço completo:
  * `street` : Rua.
  * `number` : Número.
  * `district` : Bairro.
  * `city` : Cidade.
  * `state` : Estado
  * `zip` : CEP


## Tipos de Evento de um Buffet

Lista com informações dos tipos de eventos disponíveis no buffet.

### 1. Listagem com todos os tipos de evento de determinado Buffet

__Requisição:__ `GET /api/v1/buffets/bufffet_id/events`

A partir do ID de um buffet (_buffet_id_), é retornado os tipos de eventos cadastrados.

#### Respostas

|Status|                                             |
|------|---------------------------------------------|
| 200  | lista com informações dos eventos           |
| 204  | não há eventos para o buffet correspondente |
| 404  | ID fornecido não é de um buffet cadastrado  |
| 500  | erro do servidor                            |


_Exemplo de JSON da resposta 200 para `GET /api/v1/buffets/1/events`:_
```
[
  {
    "id":1,
    "name":"Festa de Casamento",
    "event_description":"Todos os serviços para o seu casamento perfeito.",
    "minimum_of_people":100,
    "maximum_of_people":250,
    "duration":180,
    "menu":"Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.",
    "alcoholic_drink":"provided",
    "ornamentation":"provided",
    "valet":"provided",
    "locality":"of_choice"
  },
  {
    "id":2,
    "name":"Festa de Bodas",
    "event_description":"A festa do seu desejo.",
    "minimum_of_people":50,
    "maximum_of_people":150,
    "duration":120,
    "menu":"Bolo. Jantar.",
    "alcoholic_drink":"provided",
    "ornamentation":"provided",
    "valet":"unprovided",
    "locality":"only_on_site"
  }
]
```

* `id` : O _ID_ do tipo de evento para futura consulta.
* `name` : Nome.
* `event_description` : Descrição do evento.
* `minimum_of_people` : Quantidade mínima de convidados.
* `maximum_of_people` : Quantidade máxima convidados.
* `duration` : Duração padrão do evento (em minutos).
* `menu` : Cardápio.

  Serviços extras podendo ser fornecidos (_provided_) ou não (_unprovided_):
* `alcoholic_drink` : Bebidas alcoólicas.
* `ornamentation` : Decoração.
* `valet` : Atendente de estacionamento.
* `locality` : Local para realização do evento:
  * `only_on_site` : Exclusivamente no endereço do buffet.
  * `of_choice` : Endereço indicado pelo contratante.

### 2. Consulta de disponibilidade

É possível verificar a disponibilidade para realização de determinado evento.

__Requisição:__ `GET /api/v1/buffets/bufffet_id/events/event_id/query?date=value&number_of_guests=value`

Além de informar o ID do tipo de evento (e o _ID_ de seu Buffet correspondente), é necessário indicar a data (_date_) e a quantidade de convidados (_number_of_guests_) do evento.

##### _OBS:_ Alguns dos formatos de data aceitos são: dd/mm/aaaa, dd/mm/aa, dd-mm-aaaa, dd de mm de aaaa.

#### Respostas

|Status|                                                      |
|------|------------------------------------------------------|
| 200  | é retornado o valor prévio para o evento             |
| 204  | não há buffet ou tipos de eventos cadastrados        |
| 400  | _date_ ou _number_of_guests_ em branco               |
| 404  | ID fornecido não é de um buffet ou evento cadastrado |
| 406  | Data indiponível                                     |
| 500  | erro do servidor                                     |


_Continuando os exemplos, a resposta 200 para `GET /api/v1/buffets/1/events/1/query?date=31-12-2024&number_of_guests=150`:_
```

{
  "standard_value":3500
}
```

* `standard_value` : Valor prévio para realização do evento.

_JSONs para as respostas 400 e 406, respectivamente:_

```
{
  "error":"Número errado de argumentos."
}
```
```
{
  "error":"Data indisponível!"
}
```