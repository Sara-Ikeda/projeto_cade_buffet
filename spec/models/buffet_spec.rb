require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'erro se não tiver nome fantasia' do
        buffet = Buffet.new(trade_name: '')

        buffet.valid?
        result = buffet.errors.include?(:trade_name)

        expect(result).to be true
      end

      it 'erro se não tiver razão social' do
        buffet = Buffet.new(company_name: '')

        buffet.valid?
        result = buffet.errors.include?(:company_name)

        expect(result).to be true
      end

      it 'erro se não tiver CNPJ' do
        buffet = Buffet.new(registration_number: '')

        buffet.valid?
        result = buffet.errors.include?(:registration_number)

        expect(result).to be true
      end

      it 'erro se não tiver telefone' do
        buffet = Buffet.new(telephone: '')

        buffet.valid?
        result = buffet.errors.include?(:telephone)

        expect(result).to be true
      end

      it 'erro se não tiver e-mail' do
        buffet = Buffet.new(email: '')

        buffet.valid?
        result = buffet.errors.include?(:email)

        expect(result).to be true
      end

      it 'erro se não tiver descrição' do
        buffet = Buffet.new(description: '')

        buffet.valid?
        result = buffet.errors.include?(:description)

        expect(result).to be true
      end

      it 'erro se não tiver formas de pagamento' do
        buffet = Buffet.new(payment_types: '')

        buffet.valid?
        result = buffet.errors.include?(:payment_types)

        expect(result).to be true
      end
    end

    context 'uniqueness' do
      it 'erro quando CNPJ já estiver em uso' do
        owner = Owner.create!(email: 'sara@email.com', password: 'password')
        address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
        Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                  registration_number: '56862478000652', telephone: '55961524798',
                  email: 'noivos@contato.com', address: address, owner: owner,
                  description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
        other_buffet = Buffet.new(registration_number: '56862478000652')

        other_buffet.valid?
        result = other_buffet.errors.include?(:registration_number)

        expect(result).to be true
      end
    end
  end

  describe '#contact' do
    it 'exibe o telefone e o email' do
      buffet = Buffet.new(telephone: '55961524798', email: 'noivos@contato.com')

      result = buffet.contact

      expect(result).to eq('55961524798 | noivos@contato.com')
    end
  end
end