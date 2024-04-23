require 'rails_helper'

describe 'Dono do Buffet adiciona evento' do
  it 'a partir da página do seu buffet' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    login_as(owner)
    visit root_path
    click_on 'Adicionar Evento'

    expect(current_path).to eq new_event_path
  end

  it 'somente no seu própio buffet' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
    other_owner = Owner.create!(email: 'ikeda@email.com', password: '123654')
    other_buffet = Buffet.create!(trade_name: 'Doces e Salgados SP', company_name: 'Doces e Salgados LA',
              registration_number: '56868423000652', telephone: '55961698471',
              email: 'doces@salgados.com', address: address, owner: other_owner,
              description: 'Doces e salgados para a sua festa', payment_types: 'PIX')
    
    login_as(other_owner)
    visit buffet_path(buffet.id)

    expect(page).to_not have_button 'Adicionar Evento'
  end

  it 'com sucesso' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    login_as(owner)
    visit root_path
    click_on 'Adicionar Evento'
    fill_in 'Nome',with: 'Festa de Casamento'
    fill_in 'Descrição',with: 'Todos os serviços para o seu casamento perfeito.'
    fill_in 'Quantidade mínima de pessoas',with: '100'
    fill_in 'Quantidade máxima de pessoas',with: '250'
    fill_in 'Duração padrão',with: '180'
    fill_in 'Cardápio',with: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.'
    check 'Bebida Alcoólica'
    check 'Decoração'
    check 'Serviço de Estacionamento (Valet)'
    uncheck 'Localização'
    click_on 'Salvar'

    expect(current_path).to eq buffet_path(buffet.id)
    expect(page).to have_content 'Evento adicionado com sucesso!'
    expect(page).to have_content 'Festa de Casamento'
    expect(page).to have_content 'Todos os serviços para o seu casamento perfeito.'
  end
  
  it 'mas falha' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    login_as(owner)
    visit root_path
    click_on 'Adicionar Evento'
    fill_in 'Nome',with: 'Festas de Casamento'
    fill_in 'Descrição',with: ''
    fill_in 'Quantidade máxima de pessoas',with: ''
    fill_in 'Duração padrão',with: '180'
    uncheck 'Bebida Alcoólica'
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível adicionar:'
    expect(page).to have_content 'Descrição não pode ficar em branco!'
    expect(page).to have_content 'Quantidade máxima de pessoas não pode ficar em branco!'
  end
  
end
