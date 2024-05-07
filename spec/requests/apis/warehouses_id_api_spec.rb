require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets/1' do
    it 'sucesso:  fornece todos os detalhes do buffet exceto CNPJ e razão social' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      get '/api/v1/buffets/1'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to_not include 'company_name'
      expect(json_response.keys).to_not include 'registration_number'
      expect(json_response["trade_name"]).to eq 'Gourmet dos Noivos'
      expect(json_response["telephone"]).to eq '55961524798'
      expect(json_response["email"]).to eq 'noivos@contato.com'
      expect(json_response["trade_name"]).to eq 'Gourmet dos Noivos'
      expect(json_response["description"]).to eq 'Buffet especializado em casamento'
      expect(json_response["payment_types"]).to eq 'Cartão Débito/Crédito'
      expect(json_response["address"]["street"]).to eq 'Av Paulista'
      expect(json_response["address"]["number"]).to eq 50
      expect(json_response["address"]["district"]).to eq 'Bela Vista'
      expect(json_response["address"]["city"]).to eq 'São Paulo'
      expect(json_response["address"]["state"]).to eq 'SP'
      expect(json_response["address"]["zip"]).to eq '01153000'
    end

    it 'falha: não há buffet com o id fornecido' do
      get '/api/v1/buffets/9563294'

      expect(response.status).to eq 404
    end

    it 'falha: erro no servidor' do
      allow(Buffet).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)

      get '/api/v1/buffets/1'

      expect(response.status).to eq 500
    end
  end
end