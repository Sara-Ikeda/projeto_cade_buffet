require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets' do
    it 'sucesso: listagem completa de buffets cadastrados' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      other_owner = Owner.create!(email: 'ikeda@gmail.com', password: '112358')
      other_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                        city: 'São Paulo', state: 'SP', zip: '01153000')
      other_buffet = Buffet.create!(trade_name: 'Doces & Salgados SP', company_name: 'Doces e Salgados LA',
                      registration_number: '02946813000245', telephone: '55985943684',
                      email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                      description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

      get '/api/v1/buffets'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.first["trade_name"]).to  eq 'Gourmet dos Noivos'
      expect(json_response.last["trade_name"]).to  eq 'Doces & Salgados SP'
    end

    it 'sucesso porém não há buffets cadastrados' do
      get '/api/v1/buffets'

      expect(response.status).to eq 204
    end

    it 'falha: erro no servidor' do
      allow(Buffet).to receive(:all).and_raise(ActiveRecord::ActiveRecordError)

      get '/api/v1/buffets'

      expect(response.status).to eq 500
    end
  end
end
