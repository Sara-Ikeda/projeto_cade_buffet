require 'rails_helper'

describe 'Usuário se autentica' do
  context 'como Dono de Buffet' do
    it 'a partir da página inicial' do
      visit root_path

      within('div#owner_sign_in') do
        expect(page).to have_content 'Dono de Buffet?'
        expect(page).to have_link 'Entrar'
      end
    end
    
    it 'com sucesso' do
      Owner.create!(email: 'sara@email.com', password: 'password')

      visit root_path
      within('div#owner_sign_in') do
        click_on 'Entrar'
      end
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      within('div.actions') do
        click_on 'Entrar'
      end
      
      expect(page).to have_content 'sara@email.com'
      expect(page).to have_button 'Sair'
    end

    it 'e faz log out' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')

      login_as(owner, scope: :owner)
      visit root_path
      click_on 'Sair'

      expect(current_path).to eq root_path
      expect(page).to_not have_content 'sara@email.com'
    end
  end

  context 'como Cliente' do
    it 'a partir da página inicial' do
      visit root_path

      within('div#customer_sign_in') do
        expect(page).to have_content 'Cliente?'
        expect(page).to have_link 'Entrar'
      end
    end
    
    it 'com sucesso' do
      Customer.create!(name: 'Sara', cpf: CPF.generate, email: 'sara@email.com', password: 'password')

      visit root_path
      within('div#customer_sign_in') do
        click_on 'Entrar'
      end
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      within('div.actions') do
        click_on 'Entrar'
      end
      
      expect(page).to have_content 'Sara'
      expect(page).to have_button 'Sair'
    end

    it 'e faz log out' do
      customer = Customer.create!(name: 'Sara', cpf: CPF.generate, email: 'sara@email.com', password: 'password')

      login_as(customer, scope: :customer)
      visit root_path
      click_on 'Sair'

      expect(current_path).to eq root_path
      expect(page).to_not have_content 'Sara'
    end
  end
end