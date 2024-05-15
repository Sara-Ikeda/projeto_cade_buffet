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
        cpf = CPF.generate
        Customer.create!(name: 'Sara', cpf: cpf, email:'sara@email.com', password: '123456')
        customer = Customer.new(cpf: cpf)

        customer.valid?
        result = customer.errors.where(:cpf).last.type

        expect(result).to eq :taken
      end

      it 'não pode ter menos de 11 caracteres' do
        customer = Customer.new(cpf: 1234567892)

        customer.valid?
        result = customer.errors.where(:cpf).last.type

        expect(result).to eq :wrong_length
      end

      it 'não pode ter mais de 11 caracteres' do
        customer = Customer.new(cpf: 123456789212)

        customer.valid?
        result = customer.errors.where(:cpf).last.type

        expect(result).to eq :wrong_length
      end

      it 'tem só números inteiros' do
        customer = Customer.new(cpf: 369548795.1)

        customer.valid?
        result = customer.errors.where(:cpf).last.type

        expect(result).to eq :not_an_integer
      end

      it 'tem que ser válido' do
        customer = Customer.new(cpf: 65298415789)

        customer.valid?
        result = customer.errors.where(:cpf).last.type

        expect(result).to eq :invalid
      end
    end
  end
end
