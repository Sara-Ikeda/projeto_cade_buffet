require 'rails_helper'

describe 'Usuário vê informações de um Buffet' do
  it 'com todos os dados' do
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
    Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                   registration_number: '56862478000652', telephone: '55961524798',
                   email: 'noivos@contato.com', address: address,
                   description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    visit root_path
    click_on 'Buffets'
    click_on 'Gourmet dos Noivos'

    expect(page).to have_content 'Gourmet dos Noivos - 56862478000652'
    expect(page).to have_content 'Buffet especializado em casamento'
    expect(page).to have_content 'Contato: 55961524798 | noivos@contato.com'
    expect(page).to have_content 'Endereço: Av Paulista, 50. Bairro: Bela Vista.'
    expect(page).to have_content 'Cidade/UF: São Paulo/SP. CEP: 01153000'
    expect(page).to have_content 'Tipos de Pagamento: Cartão Débito/Crédito'
  end

  it 'e volta para a página inicial' do
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
    Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                   registration_number: '56862478000652', telephone: '55961524798',
                   email: 'noivos@contato.com', address: address,
                   description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    visit root_path
    click_on 'Buffets'
    click_on 'Gourmet dos Noivos'
    click_on 'Cadê Buffet?'

    expect(current_path).to eq root_path
  end
end