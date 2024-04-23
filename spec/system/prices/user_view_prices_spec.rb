require 'rails_helper'

describe 'Usuário vê preços do evento' do
  it 'na página do buffet' do
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
    price = Price.create!(minimum_cost: 10000, add_cost_by_person: 200,
            add_cost_by_hour: 300 ,weekday: 'Dias Úteis', event: event)

    visit root_path
    click_on 'Gourmet dos Noivos'

    expect(page).to have_content 'Para Dias Úteis'
    expect(page).to have_content 'Valor mínimo: R$ 10000,00'
    expect(page).to have_content 'Valor adicional por pessoa: R$ 200,00'
    expect(page).to have_content 'Valor adicional por hora extra: R$ 300,00'
  end

  it 'e ainda não há preços' do
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
    click_on 'Gourmet dos Noivos'

    expect(page).to have_content 'Ainda não foram cadastrados preços para esse evento!'
  end
  
end
