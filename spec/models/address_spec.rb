require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'erro se não tiver rua' do
        address = Address.new(street: '')

        address.valid?
        result = address.errors.include?(:street)

        expect(result).to be true
      end

      it 'erro se não tiver número' do
        address = Address.new(number: '')

        address.valid?
        result = address.errors.include?(:number)

        expect(result).to be true
      end

      it 'erro se não tiver cidade' do
        address = Address.new(city: '')

        address.valid?
        result = address.errors.include?(:city)

        expect(result).to be true
      end

      it 'erro se não tiver estado' do
        address = Address.new(state: '')

        address.valid?
        result = address.errors.include?(:state)

        expect(result).to be true
      end

      it 'erro se não tiver CEP' do
        address = Address.new(zip: '')

        address.valid?
        result = address.errors.include?(:zip)

        expect(result).to be true
      end
    end
  end

  describe '#path' do
    it 'exibe a rua e o bairro' do
      address = Address.new(street: 'Av Paulista', number: 50, district: 'Bela Vista')

      result = address.path

      expect(result).to eq('Av Paulista, 50. Bairro: Bela Vista')
    end

    it 'ou só a rua se não tiver bairro' do
      address = Address.new(street: 'Av Paulista', number: 50, district: '')

      result = address.path

      expect(result).to eq('Av Paulista, 50')
    end
  end
end
