require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'valid?' do
    context 'presence' do
      it 'nome é obrigatório' do
        customer = Customer.new(name: '')

        customer.valid?
        result = customer.errors.include?(:name)

        expect(result).to eq true
      end

      it 'cpf é obrigatório' do
        customer = Customer.new(cpf: '')

        customer.valid?
        result = customer.errors.include?(:cpf)

        expect(result).to eq true
      end
    end

    context 'cpf' do
      it 'é único' do
        Customer.create!(name: 'Sara', cpf: 20354968563, email:'sara@email.com', password: '123456')
        customer = Customer.new(cpf: 20354968563)

        customer.valid?
        result = customer.errors.include?(:cpf)

        expect(result).to eq true
      end

      it 'tem só números inteiros' do
        customer = Customer.new(cpf: 369548795.1)

        customer.valid?
        result = customer.errors.where(:cpf).last.type

        expect(result).to eq :not_an_integer
      end

      it 'não pode ter menos de 11 caracteres' do
        customer = Customer.new(cpf: 1234567890)

        customer.valid?
        result = customer.errors.include?(:cpf)

        expect(result).to eq true
      end

      it 'não pode ter mais de 11 caracteres' do
        customer = Customer.new(cpf: 123456789012)

        customer.valid?
        result = customer.errors.include?(:cpf)

        expect(result).to eq true
      end
    end
  end
end
