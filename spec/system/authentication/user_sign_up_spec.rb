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
      within('form') do
        fill_in 'E-mail', with: 'sara@email.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar Conta'
      end

      expect(page).to have_content 'Bem-vindo(a)! Cadastro realizado com sucesso.'
      expect(page).to have_content 'sara@email.com'
      expect(page).to have_button 'Sair'
    end
  end
end
