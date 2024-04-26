require 'rails_helper'

describe 'Usuário adiciona preço a um evento' do
  it 'mas não está autenticado' do
    
    post(event_prices_path(1), params: { prices: {minimum_cost: 6852, event_id: 54}})

    expect(response).to redirect_to new_owner_session_path
  end

  it 'e está autenticado como Cliente' do
    customer = Customer.create!(name: 'Sara', cpf: 68597496358, email: 'sara@email.com', password: 'password')

    post(customer_session_path, params: {customer: { email: 'sara@email.com', password: 'password' }})
    post(event_prices_path(1), params: { prices: {minimum_cost: 6852, event_id: 54}})

    expect(response).to redirect_to root_path
  end
end