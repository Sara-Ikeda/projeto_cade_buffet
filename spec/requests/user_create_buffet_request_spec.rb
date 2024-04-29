require 'rails_helper'

describe 'Usuário cria um Buffet' do
  it 'e não está autenticado' do
    
    post(buffets_path, params: { buffet: {trade_name: '', registration_number: '65845268000269'}})

    expect(response).to redirect_to new_owner_session_path
  end

  it 'está autenticado mas já tem Buffet' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
    
    post(owner_session_path, params: {owner: { email: 'sara@email.com', password: 'password' }})
    post(buffets_path, params: { buffet: {registration_number: '65845268000269'}, address: {id: address}})

    expect(response).to redirect_to root_path
  end

  it 'e está autenticado como Cliente' do
    customer = Customer.create!(name: 'Sara', cpf: 68597496358, email: 'sara@email.com', password: 'password')

    post(customer_session_path, params: {customer: { email: 'sara@email.com', password: 'password' }})
    post(buffets_path, params: { buffet: {trade_name: '', registration_number: '65845268000269'}})

    expect(response).to redirect_to root_path
  end
end