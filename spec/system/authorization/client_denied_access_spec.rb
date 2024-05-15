require 'rails_helper'

describe 'Usuário se autentica como cliente' do
  context 'e tenta acessar página' do
    it "para criar novo buffet" do
      customer = Customer.create!(name: 'Sara', cpf: CPF.generate,
                   email: 'sara@email.com', password: '159357')

      login_as(customer, scope: :customer)
      visit new_buffet_path

      expect(current_path).to_not eq new_buffet_path
      expect(current_path).to eq root_path
      expect(page).to have_content 'Acesso negado'
    end

    it "para criar evento" do
      customer = Customer.create!(name: 'Sara', cpf: CPF.generate,
                   email: 'sara@email.com', password: '159357')

      login_as(customer, scope: :customer)
      visit new_event_path

      expect(current_path).to_not eq new_event_path
      expect(current_path).to eq root_path
      expect(page).to have_content 'Acesso negado'
    end

    it "para adicionar preço à um evento" do
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

      customer = Customer.create!(name: 'Sara', cpf: CPF.generate,
                   email: 'sara@cliente.com', password: '159357')

      login_as(customer, scope: :customer)
      visit new_event_price_path(event.id)

      expect(current_path).to_not eq new_event_path
      expect(current_path).to eq root_path
      expect(page).to have_content 'Acesso negado'
    end
  end
end
