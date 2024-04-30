require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'valid?' do
    context 'presence' do
      it 'Data Desejada é obrigatória' do
        event = Event.new
        @order = Order.new(event: event, date: '')

        @order.valid?
        result = @order.errors.include?(:date)

        expect(result).to eq true
      end

      it 'Quantidade Estimada de Convidados é obrigatória' do
        event = Event.new
        @order = Order.new(event: event, number_of_guests: '')

        @order.valid?
        result = @order.errors.include?(:number_of_guests)

        expect(result).to eq true
      end

      it 'Mais Detalhes é obrigatório' do
        event = Event.new
        @order = Order.new(event: event, other_details: '')

        @order.valid?
        result = @order.errors.include?(:other_details)

        expect(result).to eq true
      end

      it 'Endereço é obrigatório se Evento permitir' do
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
                alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 1, buffet: buffet)
        @order = Order.new(event: event, address: '')

        @order.valid?
        result = @order.errors.include?(:address)

        expect(result).to eq true
      end
    end
  end

  describe 'Código é gerado automaticamente' do
    it 'ao criar um pedido' do
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
      customer = Customer.create!(name: 'Sara', cpf: 95863254789,
                  email: 'sara@contato.com', password: '159357')
      order = Order.new(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')

      order.save!
      result = order.code

      expect(result).to_not be_empty
      expect(result.length).to eq 8
    end

    it 'e é único' do
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
      customer = Customer.create!(name: 'Sara', cpf: 95863254789,
                  email: 'sara@contato.com', password: '159357')
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('A1B2C3D4')
      order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')
      another_order = Order.new(customer: customer, buffet: buffet, event: event, date: 5.months.from_now,
      number_of_guests: 150, other_details: 'Casamento de John e Jane')

      another_order.valid?
      result = another_order.errors.where(:code).last.type

      expect(result).to eq :taken
    end
    
    it 'e não pode ser modificado' do
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
      customer = Customer.create!(name: 'Sara', cpf: 95863254789,
                  email: 'sara@contato.com', password: '159357')
      order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                number_of_guests: 200, other_details: 'Casamento de Jane e John')

      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('E5F6G7H8')
      order.update(number_of_guests: 200)

      expect(order.code).to_not eq 'E5F6G7H8'
    end
  end
  
end
