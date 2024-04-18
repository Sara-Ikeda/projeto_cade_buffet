require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'erro se não tiver nome fantasia' do
        owner = Owner.new(email: 'sara@email.com', password: 'password')
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: '', company_name: 'Buffet Gourmet LTDA',
                            registration_number: '56862478000652', telephone: '55961524798',
                            email: 'noivos@contato.com', address: address, owner: owner,
                            description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver razão social' do
        owner = Owner.new(email: 'sara@email.com', password: 'password')
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: '',
                            registration_number: '56862478000652', telephone: '55961524798',
                            email: 'noivos@contato.com', address: address, owner: owner,
                            description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver CNPJ' do
        owner = Owner.new(email: 'sara@email.com', password: 'password')
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                            registration_number: '', telephone: '55961524798',
                            email: 'noivos@contato.com', address: address, owner: owner,
                            description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver formas de telefone' do
        owner = Owner.new(email: 'sara@email.com', password: 'password')
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                            registration_number: '56862478000652', telephone: '',
                            email: 'noivos@contato.com', address: address, owner: owner,
                            description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver e-mail' do
        owner = Owner.create!(email: 'sara@email.com', password: 'password')
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                            registration_number: '56862478000652', telephone: '55961524798',
                            email: '', address: address, owner: owner,
                            description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver descrição' do
        owner = Owner.create!(email: 'sara@email.com', password: 'password')
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                            registration_number: '56862478000652', telephone: '55961524798',
                            email: 'noivos@contato.com', address: address, owner: owner,
                            description: '', payment_types: 'Cartão Débito/Crédito')

        expect(buffet.valid?).to be false
      end

      it 'erro se não tiver formas de pagamento' do
        owner = Owner.new(email: 'sara@email.com', password: 'password')
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                            registration_number: '56862478000652', telephone: '55961524798',
                            email: 'noivos@contato.com', address: address, owner: owner,
                            description: 'Buffet especializado em casamento', payment_types: '')

        expect(buffet.valid?).to be false
      end
    end

    context 'uniqueness' do
      it 'erro quando CNPJ já estiver em uso' do
        owner = Owner.create!(email: 'sara@email.com', password: 'password')
        other_owner = Owner.new(email: 'ikeda@gmail.com', password: '112358')
        address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        other_address = Address.new(street: 'Avenida 9 de Julho', number: 1500, district: 'Jardim Paulista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
        buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                            registration_number: '56862478000652', telephone: '55961524798',
                            email: 'noivos@contato.com', address: address, owner: owner,
                            description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
        other_buffet = Buffet.new(trade_name: 'Doces & Salgados', company_name: 'Doces e Salgados LA',
                            registration_number: '56862478000652', telephone: '55985943684',
                            email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                            description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

        expect(other_buffet.valid?).to be false
      end
    end
  end

  describe '#contact' do
    it 'exibe o telefone e o email' do
      owner = Owner.new(email: 'sara@email.com', password: 'password')
      address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                            city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.new(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                          registration_number: '56862478000652', telephone: '55961524798',
                          email: 'noivos@contato.com', address: address, owner: owner,
                          description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      result = buffet.contact

      expect(result).to eq('55961524798 | noivos@contato.com')
    end
  end
end