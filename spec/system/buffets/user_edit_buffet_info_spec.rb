require 'rails_helper'

describe 'Usuário edita as informações do Buffet' do
  context 'sem alterar endereço' do
    it 'com sucesso' do
      address = Address.create!(street: 'Av Paulista', number: 50,
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                    registration_number: '56862478000652', telephone: '55961524798',
                    email: 'noivos@contato.com', address: address,
                    description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      visit root_path
      click_on 'Buffets'
      click_on 'Gourmet dos Noivos'
      click_on 'Editar'
      fill_in 'Nome Fantasia', with: 'Gourmet Bem-Casado'
      fill_in 'E-mail', with: 'casadinho@contato.com'
      fill_in 'Formas de Pagamento', with: 'Cartão Débito/Crédito e PIX'
      click_on 'Salvar'

      expect(current_path).to eq buffet_path(buffet)
      expect(page).to have_content 'Buffet atualizado com sucesso!'
      expect(page).to have_content 'Gourmet Bem-Casado - 56862478000652'
      expect(page).to have_content 'Buffet especializado em casamento'
      expect(page).to have_content 'Contato: 55961524798 | casadinho@contato.com'
      expect(page).to have_content 'Endereço: Av Paulista, 50.'
      expect(page).to have_content 'Cidade/UF: São Paulo/SP. CEP: 01153000'
      expect(page).to have_content 'Tipos de Pagamento: Cartão Débito/Crédito e PIX'
    end

    it 'mas falha' do
      address = Address.create!(street: 'Av Paulista', number: 50,
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      visit root_path
      click_on 'Buffets'
      click_on 'Gourmet dos Noivos'
      click_on 'Editar'
      fill_in 'Nome Fantasia', with: 'Gourmet Bem-Casado'
      fill_in 'Telefone', with: ''
      fill_in 'Formas de Pagamento', with: ''
      click_on 'Salvar'

      expect(page).to have_content 'Formas de Pagamento não pode ficar em branco!'
    end
  end

  
end