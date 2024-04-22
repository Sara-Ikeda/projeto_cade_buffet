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
    click_on 'Meu Buffet'
    click_on 'Adicionar Evento'

    expect(current_path).to eq new_event_path
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
    click_on 'Meu Buffet'
    click_on 'Adicionar Evento'
    fill_in 'Nome',with: 'Festas de Casamento'
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
    expect(page).to have_content 'Festas de Casamento'
    expect(page).to have_content 'Todos os serviços para o seu casamento perfeito.'
  end
  
end
