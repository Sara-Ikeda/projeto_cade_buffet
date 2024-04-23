require 'rails_helper'

describe 'Dono é redirecionado para cadastrar seu Buffet' do
  context 'após criar a conta' do
    it 'automaticamento' do
      visit root_path
      within('div#owner_sign_in') do
        click_on 'Entrar'
      end
      click_on 'Criar conta'
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Conta'

      expect(current_path).to eq new_buffet_path
      expect(page).to have_field 'Nome Fantasia'
      expect(page).to have_field 'Razão Social'
      expect(page).to have_field 'CNPJ'
      expect(page).to have_field 'Descrição'
      expect(page).to have_field 'Telefone'
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Formas de Pagamento'
      expect(page).to have_field 'Rua'
      expect(page).to have_field 'Número'
      expect(page).to have_field 'Bairro'
      expect(page).to have_field 'Cidade'
      expect(page).to have_field 'Estado'
      expect(page).to have_field 'CEP'
      expect(page).to have_button 'Salvar'
    end

    it 'mesmo tentando acessar outra página' do
      visit root_path
      within('div#owner_sign_in') do
        click_on 'Entrar'
      end
      click_on 'Criar conta'
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Conta'
      click_on 'Cadê Buffet?'

      expect(current_path).to eq new_buffet_path
      expect(page).to have_content 'Você ainda não cadastrou seu Buffet!'
      expect(page).to have_field 'Nome Fantasia'
    end

    it 'e cria com sucesso' do
      visit root_path
      within('div#owner_sign_in') do
        click_on 'Entrar'
      end
      click_on 'Criar conta'
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Conta'
      fill_in 'Nome Fantasia', with: 'Gourmet dos Noivos'
      fill_in 'Razão Social', with: 'Buffet Gourmet LTDA'
      fill_in 'CNPJ', with: '56862478000652'
      fill_in 'Descrição', with: 'Buffet especializado em casamento'
      fill_in 'Telefone', with: '55961524798'
      fill_in 'E-mail', with: 'noivos@contato.com'
      fill_in 'Formas de Pagamento', with: 'Cartão Débito/Crédito'
      fill_in 'Rua', with: 'Av Paulista'
      fill_in 'Número', with: '50'
      fill_in 'Bairro', with: 'Bela Vista'
      fill_in 'Cidade', with: 'São Paulo'
      fill_in 'Estado', with: 'SP'
      fill_in 'CEP', with: '01153000'
      click_on 'Salvar'

      buffet = Buffet.last
      expect(current_path).to eq buffet_path(buffet)
      expect(page).to have_content 'Buffet cadastrado com sucesso!'
      expect(page).to have_content 'Gourmet dos Noivos - 56862478000652'
      expect(page).to have_content 'Endereço: Av Paulista, 50. Bairro: Bela Vista.'
    end

    it 'mas cadastro falha' do
      visit root_path
      within('div#owner_sign_in') do
        click_on 'Entrar'
      end
      click_on 'Criar conta'
      fill_in 'E-mail', with: 'sara@email.com'
      fill_in 'Senha', with: 'password'
      fill_in 'Confirme sua senha', with: 'password'
      click_on 'Criar Conta'
      fill_in 'Nome Fantasia', with: 'Gourmet dos Noivos'
      fill_in 'Razão Social', with: 'Buffet Gourmet LTDA'
      fill_in 'Formas de Pagamento', with: ''
      fill_in 'Rua', with: ''
      fill_in 'Número', with: ''
      fill_in 'CEP', with: '01153000'
      click_on 'Salvar'

      expect(page).to have_content 'Falha ao criar:'
      expect(page).to have_content 'Rua não pode ficar em branco!'
      expect(page).to have_content 'Formas de Pagamento não pode ficar em branco!'
    end

    
  end

  it 'após relogar sem ter cadastrado antes' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')

    login_as(owner)
    visit root_path

    expect(current_path).to eq new_buffet_path
    expect(page).to have_content 'Você ainda não cadastrou seu Buffet!'
    expect(page).to have_field 'Nome Fantasia'
  end
end
