require 'rails_helper'

describe 'Dono de Buffet vê pedidos para seu Buffet' do
  it 'e deve estar autenticado' do
    visit root_path

    expect(page).to_not have_link 'Pedidos'
  end

  it 'e vê primeiro os pedidos Aguardando avaliação' do
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
    another_order = Order.create!(customer: customer, buffet: buffet, event: event, date: 5.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de A e B')
    order.confirmed!

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Pedidos'

    expect(page).to have_content 'Pedidos'
    within('#owner_orders > div:nth-of-type(1)') do
      expect(page).to have_content 'Aguardando Avaliação'
      expect(page).to have_content "Pedido #{another_order.code}"
    end
    within('#owner_orders > div:nth-of-type(2)') do
      expect(page).to have_content 'Aprovados'
      expect(page).to_not have_content "Pedido "
    end
    within('#owner_orders > div:nth-of-type(3)') do
      expect(page).to have_content 'Confirmados'
      expect(page).to have_content "Pedido #{order.code}"
    end
    within('#owner_orders > div:nth-of-type(4)') do
      expect(page).to have_content 'Cancelados'
      expect(page).to_not have_content "Pedido "
    end
  end

  it 'e não há pedidos aguardando avaliação' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Pedidos'

    expect(page).to have_content 'Pedidos'
    within('#owner_orders > div:nth-of-type(1)') do
      expect(page).to have_content 'Aguardando Avaliação'
      expect(page).to have_content "Não há pedidos aguardando avaliação."
    end
  end
end
