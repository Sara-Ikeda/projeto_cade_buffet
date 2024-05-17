require 'rails_helper'

describe 'Dono de Buffet aprova pedido' do
  it 'pela página de detalhes do pedido' do
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

    customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                email: 'jane@email.com', password: '159357')
    order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Pedidos'
    click_on "#{order.code}"

    expect(page).to have_button 'Aprovar Pedido'
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

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Pedidos'
    click_on "#{order.code}"
    click_on 'Aprovar Pedido'
    fill_in 'Data de Validade', with: 1.week.from_now
    choose 'Nenhuma'
    fill_in 'Valor', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Meios de Pagamento', with: 'Pix. Transferência. Débito. Crédito até 12x.'
    click_on 'Aprovar'

    expect(current_path).to eq orders_path
    expect(page).to have_content 'Pedido Aprovado. Esperando Confirmação do Cliente.'
    within('#owner_orders > div:nth-of-type(2)') do
      expect(page).to have_content 'Aprovados'
      expect(page).to have_content "Pedido #{order.code}"
    end
  end

  it 'mas falha' do
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

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Pedidos'
    click_on "#{order.code}"
    click_on 'Aprovar Pedido'
    fill_in 'Data de Validade', with: ''
    choose 'Acréscimo'
    fill_in 'Valor', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Meios de Pagamento', with: ''
    click_on 'Aprovar'

    expect(current_path).to_not eq orders_path
    expect(page).to have_content 'Não foi possível aprovar o pedido.'
    expect(page).to have_content 'Data de Validade não pode ficar em branco!'
    expect(page).to have_content 'Meios de Pagamento não pode ficar em branco!'
    expect(page).to have_content 'Valor não pode ficar em branco!'
    expect(page).to have_content 'Descrição não pode ficar em branco!'
  end

  it 'e não pode aprovar que estejam fora da categoria de aguardando aprovação' do
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

    customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                email: 'jane@email.com', password: '159357')
    order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')
    order.canceled!

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Pedidos'
    click_on "#{order.code}"

    expect(page).to_not have_button 'Aprovar Pedido'
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
    Price.create!(minimum_cost: 3000, add_cost_by_person: 100,
                  add_cost_by_hour: 150 ,weekday: 'Dias Úteis', event: event)
    Price.create!(minimum_cost: 4500, add_cost_by_person: 200,
                  add_cost_by_hour: 300 ,weekday: 'Fim de Semana', event: event)

    customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                email: 'jane@email.com', password: '159357')
    order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')

    other_owner = Owner.create!(email: 'ikeda@gmail.com', password: '112358')
    other_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
    other_buffet = Buffet.create!(trade_name: 'Doces & Salgados SP', company_name: 'Doces e Salgados LA',
                registration_number: '02946813000245', telephone: '55985943684',
                email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

    login_as(other_owner, scope: :owner)
    visit new_order_order_budget_path(order)

    expect(current_path).to eq buffet_path(other_buffet)
    expect(page).to have_content 'Acesso negado!'
  end
end
