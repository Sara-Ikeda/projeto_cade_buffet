require 'rails_helper'

RSpec.describe Price, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'Valor mínimo é obrigatório' do
        price = Price.new(minimum_cost: '')

        price.valid?
        result = price.errors.include?(:minimum_cost)

        expect(result).to eq true
      end

      it 'Valor adicional por pessoa é obrigatório' do
        price = Price.new(add_cost_by_person: '')

        price.valid?
        result = price.errors.include?(:add_cost_by_person)

        expect(result).to eq true
      end

      it 'Valor adicional por hora extra é obrigatório' do
        price = Price.new(add_cost_by_hour: '')

        price.valid?
        result = price.errors.include?(:add_cost_by_hour)

        expect(result).to eq true
      end

      it 'Dias é obrigatório' do
        price = Price.new(weekday: '')

        price.valid?
        result = price.errors.include?(:weekday)

        expect(result).to eq true
      end
    end

    it "inclusion - Dias só pode ser Fim de Semana ou Dias Úteis" do
      price = Price.new(weekday: 'Feriado')

        price.valid?
        result = price.errors.include?(:weekday)

        expect(result).to eq true
    end
  end
end
