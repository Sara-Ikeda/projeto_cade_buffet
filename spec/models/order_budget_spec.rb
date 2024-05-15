require 'rails_helper'

RSpec.describe OrderBudget, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'Data limite é obrigatória' do
        orderbudget = OrderBudget.new(deadline: '')

        orderbudget.valid?
        result = orderbudget.errors.include?(:deadline)

        expect(result).to be true
      end

      it 'Meios de Pagamento é obrigatória' do
        orderbudget = OrderBudget.new(payment_options: '')

        orderbudget.valid?
        result = orderbudget.errors.include?(:payment_options)

        expect(result).to be true
      end
    end

    context 'presence se tiver taxa extra/desconto' do
      it 'Valor da taxa é obrigatório' do
        orderbudget = OrderBudget.new(rate_value: '', rate: 4)

        orderbudget.valid?
        result = orderbudget.errors.include?(:rate_value)

        expect(result).to be true
      end

      it 'Descrição da taxa é obrigatória' do
        orderbudget = OrderBudget.new(rate_description: '', rate: 8)

        orderbudget.valid?
        result = orderbudget.errors.include?(:rate_description)

        expect(result).to be true
      end
    end
  end

  describe '#calculate_standard_value' do
    it 'calcula automaticamento o valor-padrão' do
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
      Price.create!(minimum_cost: 3000, add_cost_by_person: 100,
                    add_cost_by_hour: 150 ,weekday: 'Dias Úteis', event: event)
      Price.create!(minimum_cost: 4500, add_cost_by_person: 200,
                    add_cost_by_hour: 300 ,weekday: 'Fim de Semana', event: event)
  
      customer = Customer.create!(name: 'Jane', cpf: CPF.generate,
                  email: 'jane@email.com', password: '159357')
      order = Order.create!(customer: customer, buffet: buffet, event: event, date: 3.months.from_now,
                  number_of_guests: 200, other_details: 'Casamento de Jane e John')
      orderbudget = OrderBudget.new(order: order)

      result = orderbudget.standard_value

      if 3.months.from_now.on_weekday?
        expect(result).to eq (200-100)*100+3000
      else
        expect(result).to eq (200-100)*200+4500
      end
    end
  end
end
