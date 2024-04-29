require 'rails_helper'

describe 'Dono do Buffet define preço' do
  it 'a partir da página do seu buffet (página inicial)' do
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

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Definir Preços-Base'

    expect(current_path).to eq new_event_price_path(event.id)
  end

  it 'somente no evento do seu própio buffet' do
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
    other_owner = Owner.create!(email: 'ikeda@email.com', password: '123654')
    other_buffet = Buffet.create!(trade_name: 'Doces e Salgados SP', company_name: 'Doces e Salgados LA',
              registration_number: '56868423000652', telephone: '55961698471',
              email: 'doces@salgados.com', address: address, owner: other_owner,
              description: 'Doces e salgados para a sua festa', payment_types: 'PIX')
    
    login_as(other_owner, scope: :owner)
    visit new_event_price_path(event.id)

    expect(current_path).to_not eq new_event_price_path(event.id)
    expect(page).to_not have_link 'Você não tem acesso a esse Buffet.'
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

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Definir Preços-Base'

    fill_in 'Valor mínimo', with: '1_000'
    fill_in 'Valor adicional por pessoa', with: '100'
    fill_in 'Valor adicional por hora extra', with: '200'
    select 'Dias Úteis', from: 'Dias'
    click_on 'Salvar'

    expect(current_path).to eq buffet_path(buffet)
    expect(page).to have_content 'Preços-Base adicionado à Festa de Casamento'
    expect(page).to have_content 'Para Dias Úteis'
    expect(page).to have_content 'Valor mínimo: R$ 1000,00'
    expect(page).to have_content 'Valor adicional por pessoa: R$ 100,00'
    expect(page).to have_content 'Valor adicional por hora extra: R$ 200,00'
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

    login_as(owner, scope: :owner)
    visit root_path
    click_on 'Definir Preços-Base'

    fill_in 'Valor mínimo', with: '1_000'
    fill_in 'Valor adicional por pessoa', with: ''
    fill_in 'Valor adicional por hora extra', with: ''
    click_on 'Salvar'

    expect(current_path).to_not eq buffet_path(buffet)
    expect(page).to have_content 'Verifique os erros:'
    expect(page).to have_content 'Valor adicional por pessoa não pode ficar em branco'
    expect(page).to have_content 'Valor adicional por hora extra não pode ficar em branco'
  end
end
