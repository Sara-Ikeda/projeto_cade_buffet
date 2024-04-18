require 'rails_helper'

describe 'Usuário se autentica' do
  context 'como Dono de Buffet' do
    it 'com sucesso' do
      Owner.create!(email: 'sara@email.com', password: 'password')

      visit root_path
      within('div#owner_sign_in') do
        click_on 'Entrar'
      end
      within('form') do
        fill_in 'E-mail', with: 'sara@email.com'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
      end

      expect(page).to have_content 'sara@email.com'
      expect(page).to have_button 'Sair'
      expect(page).to_not have_content 'Dono de Buffet?'
    end

    it 'e faz log out' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')

      login_as(owner)
      visit root_path
      click_on 'Sair'

      expect(current_path).to eq root_path
      expect(page).to_not have_content 'sara@email.com'
    end
  end
end