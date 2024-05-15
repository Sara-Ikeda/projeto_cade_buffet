require 'rails_helper'

describe 'Cliente confirma pedido' do
  it 'acessando o pedido pelo menu Meus Pedidos' do
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
    Price.create!(minimum_cost: 3000, add_cost_by_person: 100,
                  add_cost_by_hour: 150 ,weekday: 'Dias Úteis', event: event)
    Price.create!(minimum_cost: 4500, add_cost_by_person: 200,
                  add_cost_by_hour: 300 ,weekday: 'Fim de Semana', event: event)

    customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                email: 'jane@email.com', password: '159357')
    order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')
    order_budget = OrderBudget.create!(order: order, deadline: 2.weeks.from_now,
                    payment_options: 'Cartão Débito/Crédito (12x)')
    order.approved!

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'O pedido foi aprovado pelo Buffet. Confirme o orçamento.'
    expect(page).to have_content 'Status: Aprovado'
    expect(page).to have_content "Valor-Padrão: #{order_budget.standard_value}"
    expect(page).to have_content 'Meios de Pagamento: Cartão Débito/Crédito (12x)'
    expect(page).to have_content "Data limite para confirmação: #{order_budget.deadline}"
    expect(page).to have_button "Confirmar"
  end

  it 'com sucesso' do
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
    Price.create!(minimum_cost: 3000, add_cost_by_person: 100,
                  add_cost_by_hour: 150 ,weekday: 'Dias Úteis', event: event)
    Price.create!(minimum_cost: 4500, add_cost_by_person: 200,
                  add_cost_by_hour: 300 ,weekday: 'Fim de Semana', event: event)

    customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                email: 'jane@email.com', password: '159357')
    order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')
    order_budget = OrderBudget.create!(order: order, deadline: 2.weeks.from_now,
                    payment_options: 'Cartão Débito/Crédito (12x)')
    order.approved!

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Confirmar'

    expect(page).to have_content "Pedido #{order.code} Confirmado"
    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Status: Confirmado"
    expect(page).to have_content "Valor-Padrão: #{order_budget.standard_value}"
    expect(page).to have_content 'Meios de Pagamento: Cartão Débito/Crédito (12x)'
    expect(page).to_not have_content "Data limite para confirmação: #{order_budget.deadline}"
    expect(page).to_not have_button "Confirmar"
  end

  it 'mas passou a data limite' do
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
    Price.create!(minimum_cost: 3000, add_cost_by_person: 100,
                  add_cost_by_hour: 150 ,weekday: 'Dias Úteis', event: event)
    Price.create!(minimum_cost: 4500, add_cost_by_person: 200,
                  add_cost_by_hour: 300 ,weekday: 'Fim de Semana', event: event)

    customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                email: 'jane@email.com', password: '159357')
    order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')
    order_budget = OrderBudget.create!(order: order, deadline: Date.today-1.day,
                    payment_options: 'Cartão Débito/Crédito (12x)')
    order.approved!

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content "A data limite para confirmação expirou."
    expect(page).to have_content "Status: Cancelado"
    expect(page).to have_content "Valor-Padrão: #{order_budget.standard_value}"
    expect(page).to have_content 'Meios de Pagamento: Cartão Débito/Crédito (12x)'
    expect(page).to have_content "Data limite para confirmação: #{order_budget.deadline}"
    expect(page).to_not have_button "Confirmar"
  end

  it 'e não é o cliente que fez o pedido' do
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
    Price.create!(minimum_cost: 3000, add_cost_by_person: 100,
                  add_cost_by_hour: 150 ,weekday: 'Dias Úteis', event: event)
    Price.create!(minimum_cost: 4500, add_cost_by_person: 200,
                  add_cost_by_hour: 300 ,weekday: 'Fim de Semana', event: event)

    customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                email: 'jane@email.com', password: '159357')
    order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')
    order_budget = OrderBudget.create!(order: order, deadline: 2.weeks.from_now,
                    payment_options: 'Cartão Débito/Crédito (12x)')
    order.approved!

    other_customer = Customer.create!(name: 'John', cpf: CPF.generate,
                      email: 'john@email.com', password: '246810')

    login_as(other_customer, scope: :customer)
    visit confirm_order_path(order)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Acesso negado!'
  end
end
