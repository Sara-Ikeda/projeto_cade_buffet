require 'rails_helper'

describe 'Usuário cria um pedido' do
  it 'e não está autenticado' do
    post(event_orders_path(1), params: { order: {number_of_guests: 200, event_id: 1}})

    expect(response).to redirect_to new_customer_session_path
  end

  it 'e está autenticado como Dono de Buffet' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    post(owner_session_path, params: {owner: { email: 'sara@email.com', password: 'password' }})
    post(event_orders_path(1), params: { order: {number_of_guests: 200, event_id: 1}})

    expect(response).to redirect_to root_path
  end

end