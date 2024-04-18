require 'rails_helper'

describe 'Dono edita as informações do Buffet' do
  it 'a partir da página do seu buffet' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                  registration_number: '56862478000652', telephone: '55961524798',
                  email: 'noivos@contato.com', address: address, owner: owner,
                  description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    login_as(owner)
    visit root_path
    within('nav') do
      click_on 'Meu Buffet'
    end
    click_on 'Editar'

    expect(page).to have_content 'Editar Buffet'
    expect(page).to have_field 'Nome Fantasia', with: 'Gourmet dos Noivos'
    expect(page).to have_field 'Razão Social', with: 'Buffet Gourmet LTDA'
    expect(page).to have_field 'CNPJ', with: '56862478000652'
    expect(page).to have_field 'Descrição', with: 'Buffet especializado em casamento'
    expect(page).to have_field 'Telefone', with: '55961524798'
    expect(page).to have_field 'E-mail', with: 'noivos@contato.com'
    expect(page).to have_field 'Formas de Pagamento', with: 'Cartão Débito/Crédito'
    expect(page).to have_field 'Rua', with: 'Av Paulista'
    expect(page).to have_field 'Número', with: '50'
    expect(page).to have_field 'Bairro', with: 'Bela Vista'
    expect(page).to have_field 'Cidade', with: 'São Paulo'
    expect(page).to have_field 'Estado', with: 'SP'
    expect(page).to have_field 'CEP', with: '01153000'
    expect(page).to have_button 'Salvar'
  end
  
  context 'sem alterar endereço' do
    it 'com sucesso' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50,
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                    registration_number: '56862478000652', telephone: '55961524798',
                    email: 'noivos@contato.com', address: address, owner: owner,
                    description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      login_as(owner)
      visit root_path
      click_on 'Meu Buffet'
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
      expect(page).to have_content 'Tipos de Pagamento: Cartão Débito/Crédito e PIX'
    end

    it 'mas falha' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50,
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address, owner: owner,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      login_as(owner)
      visit root_path
      click_on 'Meu Buffet'
      click_on 'Editar'
      fill_in 'Nome Fantasia', with: 'Gourmet Bem-Casado'
      fill_in 'Telefone', with: ''
      fill_in 'Formas de Pagamento', with: ''
      click_on 'Salvar'

      expect(page).to have_content 'Formas de Pagamento não pode ficar em branco!'
      expect(page).to have_content 'Telefone não pode ficar em branco!'
    end
  end

  context 'alterando endereço também' do
    it 'com sucesso' do
      owner = Owner.create!(email: 'sara@email.com', password: 'password')
      address = Address.create!(street: 'Av Paulista', number: 50,
                                city: 'São Paulo', state: 'SP', zip: '01153000')
      buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                              registration_number: '56862478000652', telephone: '55961524798',
                              email: 'noivos@contato.com', address: address, owner: owner,
                              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

      login_as(owner)
      visit root_path
      click_on 'Meu Buffet'
      click_on 'Editar'
      fill_in 'Nome Fantasia', with: 'Gourmet Bem-Casado'
      fill_in 'Rua', with: 'Av 23 de Maio'
      fill_in 'Número', with: '99'
      click_on 'Salvar'

      expect(current_path).to eq buffet_path(buffet)
      expect(page).to have_content 'Buffet atualizado com sucesso!'
      expect(page).to have_content 'Gourmet Bem-Casado - 56862478000652'
      expect(page).to have_content 'Endereço: Av 23 de Maio, 99. Bairro: Bela Vista.'
    end

  #   it 'mas falha' do
  #     owner = Owner.create!(email: 'sara@email.com', password: 'password')
  #     address = Address.create!(street: 'Av Paulista', number: 50,
  #                               city: 'São Paulo', state: 'SP', zip: '01153000')
  #     buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
  #                             registration_number: '56862478000652', telephone: '55961524798',
  #                             email: 'noivos@contato.com', address: address, owner: owner,
  #                             description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

  #     login_as(owner)
  #     visit root_path
  #     click_on 'Meu Buffet'
  #     click_on 'Editar'
  #     fill_in 'Nome Fantasia', with: 'Gourmet Bem-Casado'
  #     # fill_in 'Telefone', with: ''
  #     # fill_in 'Formas de Pagamento', with: ''
  #     fill_in 'Rua', with: ''
  #     click_on 'Salvar'

  #     # expect(page).to have_content 'Formas de Pagamento não pode ficar em branco!'
  #     # expect(page).to have_content 'Telefone não pode ficar em branco!'
  #     # expect(page).to have_content 'Rua não pode ficar em branco!'
  #     expect(current_path).to eq buffet_path(buffet)
  #   end
  end
end