require 'rails_helper'

describe 'Usuário cria conta' do
  context 'como Dono de Buffet' do
    it 'a partir da página inicial' do
      visit root_path
      within('div#owner_sign_in') do
        click_on 'Entrar'
      end
      click_on 'Criar conta'
      
      expect(current_path).to eq new_owner_registration_path
      expect(page).to have_content 'Criar Conta como Dono de Buffet'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_button 'Criar Conta'
    end

    it 'com sucesso' do
      visit root_path
      within('div#owner_sign_in') do
        click_on 'Entrar'
      end
      click_on 'Criar conta'
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Conta'

      expect(page).to have_content 'Bem-vindo(a)! Cadastro realizado com sucesso.'
      expect(page).to have_content 'sara@email.com'
      expect(page).to have_button 'Sair'
      expect(page).to_not have_content 'Dono de Buffet?'
      expect(page).to_not have_content 'Cliente?'
    end
  end

  context 'como Cliente' do
    it 'a partir da página inicial' do
      visit root_path
      within('div#customer_sign_in') do
        click_on 'Entrar'
      end
      click_on 'Criar conta'
      
      expect(current_path).to eq new_customer_registration_path
      expect(page).to have_content 'Criar Conta como Cliente'
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'CPF'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_button 'Criar Conta'
    end

    it 'com sucesso' do
      visit root_path
      within('div#customer_sign_in') do
        click_on 'Entrar'
      end
      click_on 'Criar conta'
      fill_in 'Nome', with: 'Sara'
      fill_in 'CPF', with: CPF.generate
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Conta'

      expect(page).to have_content 'Bem-vindo(a)! Cadastro realizado com sucesso.'
      expect(page).to have_content 'Sara'
      expect(page).to have_button 'Sair'
      expect(page).to_not have_content 'Dono de Buffet?'
      expect(page).to_not have_content 'Cliente?'
    end
  end
end
