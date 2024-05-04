require 'rails_helper'

describe 'Usuário cria um orçamento de um pedido' do
  it 'e não está autenticado' do
    post(order_order_budgets_path(1), params: { order_budget: {deadline: 1.month.from_now, order_id: 1}})

    expect(response).to redirect_to new_owner_session_path
  end

  it 'e está autenticado como Cliente' do
    customer = Customer.create!(name: 'Sara', cpf: 69574269584, email: 'sara@email.com', password: 'password')
    
    post(customer_session_path, params: {customer: { email: 'sara@email.com', password: 'password' }})
    post(order_order_budgets_path(1), params: { order_budget: {deadline: 1.month.from_now, order_id: 1}})

    expect(response).to redirect_to root_path
  end

end