require 'rails_helper'

describe 'Events API' do
  context 'GET /api/v1/buffets/1/query?date=value&number_of_guests=value' do
    it 'sucesso: retorna o valor padrão do pedido' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
      event = Event.create!(name: 'Festa de Casamento', event_description: 
                'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
                duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
                alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: buffet)
      Price.create!(minimum_cost: 10000, add_cost_by_person: 200,
                add_cost_by_hour: 300 ,weekday: 'Dias Úteis', event: event)
      Price.create!(minimum_cost: 15000, add_cost_by_person: 250,
                add_cost_by_hour: 500 ,weekday: 'Fim de Semana', event: event)

      get "/api/v1/buffets/1/events/1/query?date=#{1.months.from_now}&number_of_guests=150"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      if 1.months.from_now.on_weekday?
        expect(json_response["standard_value"]).to eq (150-100)*200+10000
      else
        expect(json_response["standard_value"]).to eq (150-100)*250+15000
      end
    end

    it 'falha: não é possível realizar o evento na data fornecida' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
      event = Event.create!(name: 'Festa de Casamento', event_description: 
                'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
                duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
                alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: buffet)
      Price.create!(minimum_cost: 10000, add_cost_by_person: 200,
                add_cost_by_hour: 300 ,weekday: 'Dias Úteis', event: event)
      Price.create!(minimum_cost: 15000, add_cost_by_person: 250,
                add_cost_by_hour: 500 ,weekday: 'Fim de Semana', event: event)

      customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                  email: 'jane@email.com', password: '159357')
       order = Order.create!(customer: customer, buffet: buffet, event: event, date: 1.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')

      get "/api/v1/buffets/1/events/1/query?date=#{1.months.from_now}&number_of_guests=150"

      expect(response.status).to eq 406
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Data indisponível!'
    end

    it 'falha: não forneceu a data' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
      event = Event.create!(name: 'Festa de Casamento', event_description: 
                'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
                duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
                alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: buffet)
      
      get "/api/v1/buffets/1/events/1/query?number_of_guests=150"

      expect(response.status).to eq 400
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Número errado de argumentos.'
    end

    it 'falha: não forneceu o número de convidados' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
      event = Event.create!(name: 'Festa de Casamento', event_description: 
                'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
                duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
                alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: buffet)
      
      get "/api/v1/buffets/1/events/1/query?date=#{1.months.from_now}"

      expect(response.status).to eq 400
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response["error"]).to eq 'Número errado de argumentos.'
    end

    it 'falha: id de evento não encontrado' do
      
      get "/api/v1/buffets/1/events/1/query?date=#{1.months.from_now}&number_of_guests=150"

      expect(response.status).to eq 404
    end

    it 'falha: erro no servidor' do
      allow(Event).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)
      
      get "/api/v1/buffets/1/events/1/query?date=#{1.months.from_now}&number_of_guests=150"

      expect(response.status).to eq 500
    end
  end
end
