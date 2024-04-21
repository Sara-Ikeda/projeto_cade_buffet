require 'rails_helper'

describe 'Dono edita as informações do Buffet' do
  it 'e deve estar autenticado' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    visit edit_buffet_path(buffet.id)

    expect(current_path).to eq new_owner_session_path
  end

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
    fill_in 'Rua', with: 'Av. 9 de Julho'
    fill_in 'Número', with: '99'
    click_on 'Salvar'

    expect(current_path).to eq buffet_path(buffet)
    expect(page).to have_content 'Buffet atualizado com sucesso!'
    expect(page).to have_content 'Gourmet Bem-Casado - 56862478000652'
    expect(page).to have_content 'Buffet especializado em casamento'
    expect(page).to have_content 'Contato: 55961524798 | casadinho@contato.com'
    expect(page).to have_content 'Tipos de Pagamento: Cartão Débito/Crédito e PIX'
    expect(page).to have_content 'Endereço: Av. 9 de Julho, 99'
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
    fill_in 'Rua', with: ''
    fill_in 'Estado', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Falha ao editar:'
    expect(page).to have_content 'Formas de Pagamento não pode ficar em branco!'
    expect(page).to have_content 'Telefone não pode ficar em branco!'
    expect(page).to have_content 'Rua não pode ficar em branco!'
    expect(page).to have_content 'Estado não pode ficar em branco!'
  end

  it 'e não edita Buffet de outro dono' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50,
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
    other_owner = Owner.create!(email: 'ikeda@email.com', password: '123654')
    other_buffet = Buffet.create!(trade_name: 'Doces e Salgados SP', company_name: 'Doces e Salgados LA',
              registration_number: '56868423000652', telephone: '55961698471',
              email: 'doces@salgados.com', address: address, owner: other_owner,
              description: 'Doces e salgados para a sua festa', payment_types: 'PIX')

    login_as(other_owner)
    visit edit_buffet_path(buffet.id)

    expect(current_path).to_not eq edit_buffet_path(buffet.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não pode editar esse buffet!'
  end
end