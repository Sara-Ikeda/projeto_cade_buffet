require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'erro se não tiver nome fantasia' do
        address = Address.new(street: '', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: '', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')


        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver razão social' do
        address = Address.new(street: '', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: '',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')


        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver CNPJ' do
        address = Address.new(street: '', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')


        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver e-mail' do
        address = Address.new(street: '', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: '', address: address,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')


        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver descrição' do
        address = Address.new(street: '', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address,
                              description: '', payment_types: 'Cartão Débito/Crédito')


        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver formas de pagamento' do
        address = Address.new(street: '', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address,
                              description: 'Buffet especializado em casamento', payment_types: '')


        expect(buffet.valid?).to be false
      end
    end
  end

  describe '#contact' do
    it 'exibe o telefone e o email' do
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
            
      result = buffet.contact

      expect(result).to eq('55961524798 | noivos@contato.com')
    end

    it 'exibe só o email' do
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '',
                              email: 'noivos@contato.com', address: address,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
            
      result = buffet.contact

      expect(result).to eq('noivos@contato.com')
    end
  end
end