require 'rails_helper'

describe 'Usuário vê informações do evento' do
  it 'através da página do buffet' do
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

    visit root_path
    click_on 'Buffets'
    click_on 'Gourmet dos Noivos'
    click_on 'Festa de Casamento'

    expect(page).to have_content 'Festa de Casamento do Buffet Gourmet dos Noivos'
    expect(page).to have_content 'Todos os serviços para o seu casamento perfeito.'
    expect(page).to have_content 'Quantidade mínima de pessoas: 100'
    expect(page).to have_content 'Quantidade máxima de pessoas: 250'
    expect(page).to have_content 'Cardápio: Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.'
  end
end
