require 'rails_helper'

describe 'Dono de buffet edita preço' do
  it 'à partir da tela do buffet' do
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

    within("#prices > :nth-child(1)") do
      expect(page).to have_content 'Para Dias Úteis'
      expect(page).to have_button 'Editar Preço-Base'
    end
    within("#prices > :nth-child(2)") do
      expect(page).to have_content 'Para Fim de Semana'
      expect(page).to have_button 'Editar Preço-Base'
    end
  end

  it 'e deve estar autenticado' do
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

    visit root_path
    click_on 'Gourmet dos Noivos'

    expect(page).to_not have_button 'Editar Preço-Base'
  end

  context 'com sucesso' do
    it 'sem mudar o dia da semana' do
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
      within("#prices > :nth-child(1)") do
        click_on 'Editar Preço-Base'
      end
      fill_in 'Valor mínimo', with: '1_500'
      fill_in 'Valor adicional por pessoa', with: '50'
      fill_in 'Valor adicional por hora extra', with: '100'
      select 'Dias Úteis', from: 'Dias'
      click_on 'Salvar'

      expect(current_path).to eq buffet_path(buffet)
      expect(page).to have_content 'Preço-Base editado com sucesso!'
      expect(page).to have_content 'Para Dias Úteis'
      expect(page).to have_content 'Valor mínimo: R$ 1500,00'
      expect(page).to have_content 'Valor adicional por pessoa: R$ 50,00'
      expect(page).to have_content 'Valor adicional por hora extra: R$ 100,00'
    end

    it 'mudando o dia da semana' do
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
      Price.create!(minimum_cost: 20000, add_cost_by_person: 200,
            add_cost_by_hour: 400 ,weekday: 'Fim de Semana', event: event)

      login_as(owner, scope: :owner)
      visit root_path
      click_on 'Editar Preço-Base'
      select 'Dias Úteis', from: 'Dias'
      click_on 'Salvar'

      expect(current_path).to eq buffet_path(buffet)
      expect(page).to have_content 'Preço-Base editado com sucesso!'
      expect(page).to have_content 'Para Dias Úteis'
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
    Price.create!(minimum_cost: 20000, add_cost_by_person: 200,
          add_cost_by_hour: 400 ,weekday: 'Fim de Semana', event: event)

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Editar Preço-Base'
    fill_in 'Valor adicional por pessoa', with: ''
    fill_in 'Valor adicional por hora extra', with: ''
    click_on 'Salvar'

    expect(current_path).to_not eq buffet_path(buffet)
    expect(page).to have_content 'Falha ao editar:'
    expect(page).to have_content 'Valor adicional por pessoa não pode ficar em branco!'
    expect(page).to have_content 'Valor adicional por hora extra não pode ficar em branco!'
  end
  
  it 'e não edita preço de outro buffet' do
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
    price = Price.create!(minimum_cost: 20000, add_cost_by_person: 200,
          add_cost_by_hour: 400 ,weekday: 'Fim de Semana', event: event)

    other_owner = Owner.create!(email: 'buffet2@gmail.com', password: 'password')
    other_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                      city: 'São Paulo', state: 'SP', zip: '01153000')
    other_buffet = Buffet.create!(trade_name: 'Doces e Salgados SP', company_name: 'Doces e Salgados LA',
                    registration_number: '02946813000245', telephone: '55985943684',
                    email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                    description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

    login_as(other_owner, scope: :owner)
    visit edit_event_price_path(event, price)

    expect(current_path).to eq buffet_path(other_buffet)
    expect(page).to have_content 'Acesso negado!'
  end
end
