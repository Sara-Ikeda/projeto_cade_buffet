require 'rails_helper'

describe 'Usuário cria um Buffet' do
  it 'e não está autenticado' do
    
    post(buffets_path, params: { buffet: {trade_name: '', registration_number: '65845268000269'}})

    expect(response).to redirect_to new_owner_session_path
  end

  it 'e está autenticado como Cliente' do
    customer = Customer.create!(name: 'Sara', cpf: 68597496358, email: 'sara@email.com', password: 'password')

    post(customer_session_path, params: {customer: { email: 'sara@email.com', password: 'password' }})
    post(buffets_path, params: { buffet: {trade_name: '', registration_number: '65845268000269'}})

    expect(response).to redirect_to root_path
  end
end