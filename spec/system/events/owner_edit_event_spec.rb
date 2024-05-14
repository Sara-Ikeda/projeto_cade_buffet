require 'rails_helper'

describe 'Dono de Buffet edita evento' do
  it 'e deve estar autenticado' do
    owner = Owner.create!(email: 'buffet1@email.com', password: 'password')
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

    expect(page).to_not have_button 'Editar Evento'
  end

  it 'a partir da tela do buffet' do
    owner = Owner.create!(email: 'buffet1@email.com', password: 'password')
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

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Editar Evento'

    expect(page).to have_content 'Editar Evento: Festa de Casamento'
    expect(page).to have_field 'Nome',with: 'Festa de Casamento'
    expect(page).to have_field 'Descrição',with: 'Todos os serviços para o seu casamento perfeito.'
    expect(page).to have_field 'Quantidade mínima de pessoas',with: '100'
    expect(page).to have_field 'Quantidade máxima de pessoas',with: '250'
    expect(page).to have_field 'Duração padrão',with: '180'
    expect(page).to have_field 'Cardápio',with: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.'
    expect(page).to have_checked_field 'Bebida Alcoólica'
    expect(page).to have_checked_field 'Decoração'
    expect(page).to have_checked_field 'Serviço de Estacionamento (Valet)'
    expect(page).to have_unchecked_field 'Localização'
    expect(page).to have_button 'Salvar'
  end

  it 'com sucesso' do
    owner = Owner.create!(email: 'buffet1@email.com', password: 'password')
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

    login_as(owner, scope: :owner)
    visit buffet_path(buffet)
    click_on 'Editar Evento'
    fill_in 'Quantidade mínima de pessoas',with: '50'
    fill_in 'Quantidade máxima de pessoas',with: '150'
    fill_in 'Duração padrão',with: '240'
    uncheck 'Serviço de Estacionamento (Valet)'
    check 'Localização'
    click_on 'Salvar'

    expect(page).to have_content 'Evento editado com sucesso!'
    expect(page).to have_content 'Quantidade mínima de pessoas: 50'
    expect(page).to have_content 'Quantidade máxima de pessoas: 150'
    expect(page).to have_content 'Duração padrão: 240'
    expect(page).to have_content 'Serviço de Estacionamento (Valet): Não Fornecido'
    expect(page).to have_content 'Localização: De Escolha'
  end

  it 'mas falha' do
    owner = Owner.create!(email: 'buffet1@email.com', password: 'password')
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

    login_as(owner, scope: :owner)
    visit buffet_path(buffet)
    click_on 'Editar Evento'
    fill_in 'Nome',with: ''
    fill_in 'Cardápio',with: ''
    fill_in 'Duração padrão',with: '120'
    click_on 'Salvar'

    expect(current_path).to_not eq root_path
    expect(page).to have_content 'Falha ao editar:'
    expect(page).to have_content 'Nome não pode ficar em branco!'
    expect(page).to have_content 'Cardápio não pode ficar em branco!'
  end

  it 'e não edita evento de outro buffet' do
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

    other_owner = Owner.create!(email: 'buffet2@gmail.com', password: 'password')
    other_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                      city: 'São Paulo', state: 'SP', zip: '01153000')
    other_buffet = Buffet.create!(trade_name: 'Doces e Salgados SP', company_name: 'Doces e Salgados LA',
                    registration_number: '02946813000245', telephone: '55985943684',
                    email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                    description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

    login_as(other_owner, scope: :owner)
    visit edit_event_path(event)

    expect(current_path).to eq buffet_path(other_buffet)
    expect(page).to have_content 'Acesso negado!'
  end
end
