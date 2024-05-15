require 'rails_helper'

describe 'Usuário cria um evento' do
  it 'mas não está autenticado' do
    
    post(events_path, params: { event: {name: '', buffet_id: 1}})

    expect(response).to redirect_to new_owner_session_path
  end

  it 'e está autenticado como Cliente' do
    customer = Customer.create!(name: 'Sara', cpf: CPF.generate, email: 'sara@email.com', password: 'password')

    post(customer_session_path, params: {customer: { email: 'sara@email.com', password: 'password' }})
    post(events_path, params: { event: {name: 'Festa de 15 anos', buffet_id: 1}})

    expect(response).to redirect_to root_path
  end
end