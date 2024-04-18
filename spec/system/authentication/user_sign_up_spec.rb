require 'rails_helper'

describe 'Usuário cria conta' do
  it 'como Dono de Buffet com sucesso' do
    visit root_path
    within('div#owner_sign_in') do
      click_on 'Entrar'
    end
    click_on 'Criar conta'
    within('form') do
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar conta'
    end

    expect(page).to have_content 'sara@email.com'
    expect(page).to have_button 'Sair'
  end
end
