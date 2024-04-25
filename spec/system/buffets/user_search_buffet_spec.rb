require 'rails_helper'

describe 'Usuário não autenticado busca por Buffets' do
  it 'a partir da seção de navegação' do
    visit root_path
    
    within('header nav') do
      expect(page).to have_field('Buscar Buffet')
      expect(page).to have_button('Buscar')
    end
  end

  context 'com sucesso' do
    it 'por uma parte do nome fantasia' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      other_owner = Owner.create!(email: 'ikeda@gmail.com', password: '112358')
      other_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                                      city: 'São Paulo', state: 'SP', zip: '01153000')
      Buffet.create!(trade_name: 'Doces & Salgados SP', company_name: 'Doces e Salgados LA',
                      registration_number: '02946813000245', telephone: '55985943684',
                      email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                      description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

      third_owner = Owner.create!(email: 'hime@email.com', password: '135711')
      third_address = Address.create!(street: 'Avenida Central', number: 99, district: 'Itaipu',
                                city: 'Niterói', state: 'RJ', zip: '85875000')
      Buffet.create!(trade_name: 'Doces do RJ', company_name: 'Doces LTDA',
                    registration_number: '85967518000168', telephone: '55986475932',
                    email: 'contato@doces.com', address: third_address, owner: third_owner,
                    description: 'Sua festa doce', payment_types: 'Débito/PIX')

      visit root_path
      fill_in 'Buscar Buffet', with: 'Doces'
      click_on 'Buscar'

      expect(page).to have_content 'Resultados da Busca por: Doces'
      expect(page).to have_content 'Doces & Salgados SP'
      expect(page).to have_content 'Doces e Salgados para sua festa'
      expect(page).to have_content 'Doces do RJ'
      expect(page).to have_content 'Sua festa doce'
      expect(page).to_not have_content 'Gourmet dos Noivos'
      expect(page).to_not have_content 'Buffet especializado em casamento'
    end

    it 'pela cidade' do
      first_owner = Owner.create!(email: 'sara@email.com', password: 'password')
      first_address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '5511961524798',
                email: 'noivos@contato.com', address: first_address, owner: first_owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      second_owner = Owner.create!(email: 'ikeda@gmail.com', password: '112358')
      second_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                                      city: 'São Paulo', state: 'SP', zip: '01153000')
      Buffet.create!(trade_name: 'Doces & Salgados SP', company_name: 'Doces e Salgados LA',
                      registration_number: '02946813000245', telephone: '5511985943684',
                      email: 'sac@docesesalgados.com', address: second_address, owner: second_owner,
                      description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

      third_owner = Owner.create!(email: 'hime@email.com', password: '135711')
      third_address = Address.create!(street: 'Avenida Central', number: 99, district: 'Itaipu',
                                city: 'Niterói', state: 'RJ', zip: '85875000')
      Buffet.create!(trade_name: 'Doces do RJ', company_name: 'Doces LTDA',
                    registration_number: '85967518000168', telephone: '55986475932',
                    email: 'contato@doces.com', address: third_address, owner: third_owner,
                    description: 'Sua festa doce', payment_types: 'Débito/PIX')

      visit root_path
      fill_in 'Buscar Buffet', with: 'São Paulo'
      click_on 'Buscar'

      expect(page).to have_content 'Resultados da Busca por: São Paulo'
      expect(page).to have_content 'Gourmet dos Noivos'
      expect(page).to have_content 'Buffet especializado em casamento'
      expect(page).to have_content 'Doces & Salgados SP'
      expect(page).to have_content 'Doces e Salgados para sua festa'
      expect(page).to_not have_content 'Doces do RJ'
        expect(page).to_not have_content 'Sua festa doce'
    end

    it 'pelos tipos de festa' do
      first_owner = Owner.create!(email: 'sara@email.com', password: 'password')
      first_address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      first_buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                      registration_number: '56862478000652', telephone: '5511961524798',
                      email: 'noivos@contato.com', address: first_address, owner: first_owner,
                      description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
      Event.create!(name: 'Festa de Casamento', event_description: 
                    'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
                    duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
                    alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: first_buffet)
      Event.create!(name: 'Festa de Aniversário de Casamento', event_description: 
                    'A festa do seu jeito.', minimum_of_people: 50, maximum_of_people: 150,
                    duration: 120, menu: 'Bolo. Jantar.',
                    alcoholic_drink: 1, ornamentation: 1, valet: 0, locality: 0, buffet: first_buffet)

      second_owner = Owner.create!(email: 'ikeda@gmail.com', password: '112358')
      second_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                                      city: 'São Paulo', state: 'SP', zip: '01153000')
      second_buffet = Buffet.create!(trade_name: 'Doces & Salgados SP', company_name: 'Doces e Salgados LA',
                        registration_number: '02946813000245', telephone: '5511985943684',
                        email: 'sac@docesesalgados.com', address: second_address, owner: second_owner,
                        description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')
      Event.create!(name: 'Festa de 15 anos', event_description: 
                    'A melhor festa de 15 anos.', minimum_of_people: 200, maximum_of_people: 300,
                    duration: 240, menu: 'Bolo. Doces. Salgados. Jantar.',
                    alcoholic_drink: 0, ornamentation: 1, valet: 1, locality: 0, buffet: second_buffet)

      third_owner = Owner.create!(email: 'hime@email.com', password: '135711')
      third_address = Address.create!(street: 'Avenida Central', number: 99, district: 'Itaipu',
                                city: 'Niterói', state: 'RJ', zip: '85875000')
      third_buffet = Buffet.create!(trade_name: 'Doces do RJ', company_name: 'Doces LTDA',
                      registration_number: '85967518000168', telephone: '55986475932',
                      email: 'contato@doces.com', address: third_address, owner: third_owner,
                      description: 'Sua festa doce', payment_types: 'Débito/PIX')
      Event.create!(name: 'Festa de Aniversário', event_description: 
                    'Doces para seu aniversário.', minimum_of_people: 100, maximum_of_people: 150,
                    duration: 150, menu: 'Bolo. Brigadeiros. Beijinhos.',
                    alcoholic_drink: 0, ornamentation: 1, valet: 0, locality: 1, buffet: third_buffet)

      visit root_path
      fill_in 'Buscar Buffet', with: 'Aniversário'
      click_on 'Buscar'

      expect(page).to have_content 'Resultados da Busca por: Aniversário'
      expect(page).to have_content 'Gourmet dos Noivos'
      expect(page).to have_content 'Buffet especializado em casamento'
      expect(page).to have_content 'Doces do RJ'
      expect(page).to have_content 'Sua festa doce'
      expect(page).to_not have_content 'Doces & Salgados SP'
      expect(page).to_not have_content 'Doces e Salgados para sua festa'
    end

    it 'em ordem alfabética' do
      first_owner = Owner.create!(email: 'sara@email.com', password: 'password')
      first_address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      first_buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                      registration_number: '56862478000652', telephone: '5511961524798',
                      email: 'noivos@contato.com', address: first_address, owner: first_owner,
                      description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
      Event.create!(name: 'Festa de Casamento', event_description: 
                    'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
                    duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
                    alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: first_buffet)

      second_owner = Owner.create!(email: 'ikeda@gmail.com', password: '112358')
      second_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                                      city: 'São Paulo', state: 'SP', zip: '01153000')
      second_buffet = Buffet.create!(trade_name: 'Doces & Salgados SP', company_name: 'Doces e Salgados LA',
                        registration_number: '02946813000245', telephone: '5511985943684',
                        email: 'sac@docesesalgados.com', address: second_address, owner: second_owner,
                        description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')
      Event.create!(name: 'Festa de 15 anos', event_description: 
                    'A melhor festa de 15 anos.', minimum_of_people: 200, maximum_of_people: 300,
                    duration: 240, menu: 'Bolo. Doces. Salgados. Jantar.',
                    alcoholic_drink: 0, ornamentation: 1, valet: 1, locality: 0, buffet: second_buffet)

      third_owner = Owner.create!(email: 'hime@email.com', password: '135711')
      third_address = Address.create!(street: 'Avenida Central', number: 99, district: 'Itaipu',
                                city: 'Niterói', state: 'RJ', zip: '85875000')
      third_buffet = Buffet.create!(trade_name: 'Doces do RJ', company_name: 'Doces LTDA',
                      registration_number: '85967518000168', telephone: '55986475932',
                      email: 'contato@doces.com', address: third_address, owner: third_owner,
                      description: 'Sua festa doce', payment_types: 'Débito/PIX')
      Event.create!(name: 'Festa de Aniversário', event_description: 
                    'Doces para seu aniversário.', minimum_of_people: 100, maximum_of_people: 150,
                    duration: 150, menu: 'Bolo. Brigadeiros. Beijinhos.',
                    alcoholic_drink: 0, ornamentation: 1, valet: 0, locality: 1, buffet: third_buffet)

      visit root_path
      fill_in 'Buscar Buffet', with: 'Festa'
      click_on 'Buscar'

      expect(page).to have_content 'Resultados da Busca por: Festa'
      expect(page).to have_content '3 Buffets encontrados.'
      within("#search-buffets > div:nth-of-type(1)") do
        expect(page).to have_content 'Doces & Salgados SP'
      end
      within("#search-buffets > div:nth-of-type(2)") do
        expect(page).to have_content 'Doces do RJ'
      end
      within("#search-buffets > div:nth-of-type(3)") do
        expect(page).to have_content 'Gourmet dos Noivos'
      end
    end
  end

  it 'e não há resultados compatíveis' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                registration_number: '56862478000652', telephone: '55961524798',
                email: 'noivos@contato.com', address: address, owner: owner,
                description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      visit root_path
      fill_in 'Buscar Buffet', with: 'Rio de Janeiro'
      click_on 'Buscar'

      expect(page).to have_content 'Resultados da Busca por: Rio de Janeiro'
      expect(page).to have_content '0 Buffets encontrados.'
      expect(page).to_not have_content 'Gourmet dos Noivos'
  end

  it 'e é redirecionado para a página de detalhes ao clicar no nome' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    visit root_path
    fill_in 'Buscar Buffet', with: 'São Paulo'
    click_on 'Buscar'
    click_on 'Gourmet dos Noivos'

    expect(current_path).to eq buffet_path(buffet)
  end
end
