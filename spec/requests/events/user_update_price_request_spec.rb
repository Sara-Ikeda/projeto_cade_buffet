require 'rails_helper'

describe 'Usuário edita preço de um buffet' do
  it 'mas não é dono' do
    owner = Owner.create!(email: 'buffet1@email.com', password: 'password')
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
    price = Price.create!(minimum_cost: 20000, add_cost_by_person: 200,
            add_cost_by_hour: 400 ,weekday: 'Fim de Semana', event: event)
    Price.create!(minimum_cost: 10000, add_cost_by_person: 200,
            add_cost_by_hour: 300 ,weekday: 'Dias Úteis', event: event)
    
    other_owner = Owner.create!(email: 'buffet2@gmail.com', password: 'password')
    other_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                      city: 'São Paulo', state: 'SP', zip: '01153000')
    other_buffet = Buffet.create!(trade_name: 'Doces e Salgados SP', company_name: 'Doces e Salgados LA',
                    registration_number: '02946813000245', telephone: '55985943684',
                    email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                    description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

    post(owner_session_path, params: {owner: { email: other_owner.email, password: other_owner.password }})
    patch(event_price_path(event.id, price.id), params: { price: {weekday: 'Dias Úteis'}})

    expect(response).to redirect_to root_path
  end

  it 'mas está autenticado como Cliente' do
    customer = Customer.create!(name: 'Sara', cpf: CPF.generate, email: 'sara@email.com', password: 'password')

    post(customer_session_path, params: {customer: { email: 'sara@email.com', password: 'password' }})
    patch(event_price_path(1,1), params: { price: {weekday: 'Dias Úteis'}})

    expect(response).to redirect_to root_path
  end
end