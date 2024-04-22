require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'nome é obrigatório' do
        event = Event.new(name: '')

        event.valid?
        result = event.errors.include?(:name)

        expect(result).to be true
      end

      it 'descrição é obrigatório' do
        event = Event.new(event_description: '')

        event.valid?
        result = event.errors.include?(:event_description)

        expect(result).to be true
      end

      it 'quantidade minima de pessoas é obrigatório' do
        event = Event.new(minimum_of_people: '')

        event.valid?
        result = event.errors.include?(:minimum_of_people)

        expect(result).to be true
      end

      it 'quantidade maxima de pessoas é obrigatório' do
        event = Event.new(maximum_of_people: '')

        event.valid?
        result = event.errors.include?(:maximum_of_people)

        expect(result).to be true
      end

      it 'duração é obrigatório' do
        event = Event.new(duration: '')

        event.valid?
        result = event.errors.include?(:duration)

        expect(result).to be true
      end

      it 'menu é obrigatório' do
        event = Event.new(menu: '')

        event.valid?
        result = event.errors.include?(:menu)

        expect(result).to be true
      end
    end
  end
end
