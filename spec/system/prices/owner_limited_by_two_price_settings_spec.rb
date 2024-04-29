require 'rails_helper'

describe 'Preços por tipo de evento' do
  it 'podem ser cadastrados apenas duas vezes' do
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
    Price.create!(minimum_cost: 10000, add_cost_by_person: 200,
            add_cost_by_hour: 300 ,weekday: 'Dias Úteis', event: event)
    Price.create!(minimum_cost: 20000, add_cost_by_person: 200,
            add_cost_by_hour: 400 ,weekday: 'Fim de Semana', event: event)

    login_as(owner, scope: :owner)
    visit root_path

    expect(page).to have_content 'Para Dias Úteis'
    expect(page).to have_content 'Para Fim de Semana'
    expect(page).to_not have_link 'Definir Preços-Base'
  end

  context 'pode ser cadastrado só uma vez em' do
    it 'Dias Úteis' do
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
      Price.create!(minimum_cost: 10000, add_cost_by_person: 200,
              add_cost_by_hour: 300 ,weekday: 'Dias Úteis', event: event)

      login_as(owner, scope: :owner)
      visit root_path
      click_on 'Definir Preços-Base'

      expect(page).to have_content 'Fim de Semana'
      expect(page).to_not have_content 'Dias Úteis'
    end

    it 'Fim de Semana' do
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
      Price.create!(minimum_cost: 10000, add_cost_by_person: 200,
              add_cost_by_hour: 300 ,weekday: 'Fim de Semana', event: event)

      login_as(owner, scope: :owner)
      visit root_path
      click_on 'Definir Preços-Base'

      expect(page).to have_content 'Dias Úteis'
      expect(page).to_not have_content 'Fim de Semana'
    end
  end
end
