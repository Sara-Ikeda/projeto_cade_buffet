require 'rails_helper'

describe 'Events API' do
  context 'GET /api/v1/buffets/1/events' do
    it 'sucesso: listagem dos tipos de eventos disponíveis' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
      event_a = Event.create!(name: 'Festa de Casamento', event_description: 
                'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
                duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
                alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: buffet)
      event_b = Event.create!(name: 'Festa de Bodas', event_description: 
                'A festa do seu jeito.', minimum_of_people: 50, maximum_of_people: 150,
                duration: 120, menu: 'Bolo. Jantar.',
                alcoholic_drink: 0, ornamentation: 0, valet: 0, locality: 1, buffet: buffet)

    get '/api/v1/buffets/1/events'

    expect(response.status).to eq 200
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response[0]["name"]).to eq 'Festa de Casamento'
    expect(json_response[0]["event_description"]).to eq 'Todos os serviços para o seu casamento perfeito.'
    expect(json_response[0]["minimum_of_people"]).to eq 100
    expect(json_response[0]["maximum_of_people"]).to eq 250
    expect(json_response[0]["duration"]).to eq 180
    expect(json_response[0]["menu"]).to eq 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.'
    expect(json_response[0]["alcoholic_drink"]).to eq 'provided'
    expect(json_response[0]["ornamentation"]).to eq 'provided'
    expect(json_response[0]["valet"]).to eq 'provided'
    expect(json_response[0]["locality"]).to eq 'only_on_site'
    expect(json_response[1]["name"]).to eq 'Festa de Bodas'
    expect(json_response[1]["alcoholic_drink"]).to eq 'unprovided'
    expect(json_response[1]["ornamentation"]).to eq 'unprovided'
    expect(json_response[1]["valet"]).to eq 'unprovided'
    expect(json_response[1]["locality"]).to eq 'of_choice'
    end

    it 'sucesso: mas não há eventos cadastrados' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      get '/api/v1/buffets/1/events'

      expect(response.status).to eq 204
    end

    it 'falha: erro no servidor' do
      allow(Buffet).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)

      get '/api/v1/buffets/1/events'

      expect(response.status).to eq 500
    end
  end
end
