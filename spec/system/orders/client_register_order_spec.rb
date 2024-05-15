require 'rails_helper'

describe 'Usuário faz pedido para um buffet' do
  it 'e deve estar autenticado' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
    Event.create!(name: 'Festa de Casamento', event_description: 
              'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
              duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
              alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: buffet)

    visit root_path
    click_on 'Gourmet dos Noivos'
    click_on 'Contratar Buffet'

    expect(current_path).to eq new_customer_session_path
  end

  it 'com sucesso' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
    Event.create!(name: 'Festa de Bodas', event_description: 
                  'A festa do seu jeito.', minimum_of_people: 50, maximum_of_people: 150,
                  duration: 120, menu: 'Bolo. Jantar.',
                  alcoholic_drink: 1, ornamentation: 1, valet: 0, locality: 0, buffet: buffet)
    customer = Customer.create!(name: 'Sara', cpf: CPF.generate,
                email: 'sara@contato.com', password: '159357')

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Gourmet dos Noivos'
    click_on 'Contratar Buffet'
    fill_in 'Data Desejada', with: 2.months.from_now
    fill_in 'Quantidade Estimada de Convidados', with: '100'
    fill_in 'Mais Detalhes', with: 'Aniversário de 50 anos de casamento.'
    click_on 'Enviar'

    expect(page).to have_content 'Pedido cadastrado com sucesso. Acompanhe-o em Meus Pedidos.'
    expect(current_path).to eq buffet_path(buffet)

  end

  it 'mas falha' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
    Event.create!(name: 'Festa de Casamento', event_description: 
                  'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
                  duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
                  alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 1, buffet: buffet)
    customer = Customer.create!(name: 'Sara', cpf: CPF.generate,
                email: 'sara@contato.com', password: '159357')

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Gourmet dos Noivos'
    click_on 'Contratar Buffet'
    fill_in 'Data Desejada', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Quantidade Estimada de Convidados', with: ''
    click_on 'Enviar'

    expect(page).to_not have_content 'Pedido cadastrado com sucesso. Acompanhe-o em Meus Pedidos.'
    expect(page).to have_content 'Não foi possível fazer o pedido.'
    expect(page).to have_content 'Data Desejada não pode ficar em branco!'
    expect(page).to have_content 'Endereço não pode ficar em branco!'
    expect(page).to have_content 'Quantidade Estimada de Convidados não pode ficar em branco!'
  end
end
