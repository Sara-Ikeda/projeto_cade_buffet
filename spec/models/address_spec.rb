require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'erro se não tiver rua' do
        address = Address.new(street: '', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')

        expect(address.valid?).to be false
      end

      it 'erro se não tiver número' do
        address = Address.new(street: 'Av Paulista', number: '', district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')

        expect(address.valid?).to be false
      end

      it 'erro se não tiver cidade' do
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                  city: '', state: 'SP', zip: '01153000')

        expect(address.valid?).to be false
      end

      it 'erro se não tiver estado' do
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: '', zip: '01153000')

        expect(address.valid?).to be false
      end

      it 'erro se não tiver CEP' do
        address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                  city: 'São Paulo', state: 'SP', zip: '')

        expect(address.valid?).to be false
      end
    end
    
    context 'no presence' do
      it 'sem erro mesmo sem bairro' do
        address = Address.new(street: 'Av Paulista', number: 50, district: '',
                                  city: 'São Paulo', state: 'SP', zip: '01153000')

        expect(address.valid?).to be true
      end
    end
  end

  describe '#path' do
    it 'exibe a rua e o bairro' do
      address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')

      result = address.path

      expect(result).to eq('Av Paulista, 50. Bairro: Bela Vista')
    end

    it 'ou só a rua se não tiver bairro' do
      address = Address.create!(street: 'Av Paulista', number: 50, district: '',
                                city: 'São Paulo', state: 'SP', zip: '01153000')

      result = address.path

      expect(result).to eq('Av Paulista, 50')
    end
  end
end
