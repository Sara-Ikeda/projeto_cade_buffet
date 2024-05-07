require 'rails_helper'

describe 'Usuário adiciona preço a um evento' do
  it 'mas não está autenticado' do
    
    post(event_prices_path(1), params: { price: {minimum_cost: 6852, event_id: 54}})

    expect(response).to redirect_to new_owner_session_path
  end

  it 'e não é o dono' do
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
    
    other = Owner.create!(email: 'other@email.com', password: '951753')
    Buffet.create!(trade_name: 'Doces & Salgados SP', company_name: 'Doces e Salgados LA',
                registration_number: '02946813000245', telephone: '55985943684',
                email: 'sac@docesesalgados.com', address: address, owner: other,
                description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')
    

    post(owner_session_path, params: {owner: { email: 'other@email.com', password: '951753' }})
    post(event_prices_path(event.id), params: { price: {add_cost_by_hour: 100, weekday: 'Dias Úteis'}})

    expect(response).to redirect_to root_path
  end

  it 'e é o Dono mas já tem dois cadastrados' do
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
    Price.create!(minimum_cost: 20000, add_cost_by_person: 200,
            add_cost_by_hour: 400 ,weekday: 'Fim de Semana', event: event)

    post(owner_session_path, params: {owner: { email: 'sara@email.com', password: 'password' }})
    post(event_prices_path(event.id), params: { price: {minimum_cost: 6852, weekday: 'Dias Úteis'}})

    expect(response).to redirect_to root_path
  end

  it 'e está autenticado como Cliente' do
    customer = Customer.create!(name: 'Sara', cpf: 68597496358, email: 'sara@email.com', password: 'password')

    post(customer_session_path, params: {customer: { email: 'sara@email.com', password: 'password' }})
    post(event_prices_path(1), params: { prices: {minimum_cost: 6852, event_id: 54}})

    expect(response).to redirect_to root_path
  end
end