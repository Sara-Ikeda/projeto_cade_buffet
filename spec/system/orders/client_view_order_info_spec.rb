require 'rails_helper'

describe 'Usuário vê informações do pedido' do
  it 'através do código' do
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

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_link "#{order.code}"
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

    customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                email: 'jane@email.com', password: '159357')
    order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content "Pedido #{order.code}"
    expect(page).to have_content "Buffet Contratado: Gourmet dos Noivos"
    expect(page).to have_content "Para o Tipo de Evento: Festa de Casamento"
    expect(page).to have_content "Data Desejada: #{I18n.localize(order.date)}"
    expect(page).to have_content "Número Estimado de Convidados: 200"
    expect(page).to have_content "Mais Detalhes: Casamento de Jane e John"
    expect(page).to have_content "Status: Aguardando Avaliação"
  end

end
