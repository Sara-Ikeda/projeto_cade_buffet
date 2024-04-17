require 'rails_helper'

describe 'Usuário vê lista de Buffets' do
  it 'a partir da tela inicial' do
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
    Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                   registration_number: '56862478000652', telephone: '55961524798',
                   email: 'noivos@contato.com', address: address,
                   description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    visit root_path
    click_on 'Buffets'

    expect(page).to_not have_content 'Não há Buffets disponíveis no momento.'
    expect(page).to have_content 'Gourmet dos Noivos'
    expect(page).to have_content 'Contato: 55961524798 | noivos@contato.com'
    expect(page).to have_content 'Localização: São Paulo - SP'
  end

  it 'mas não há buffets cadastrados' do
    visit root_path
    click_on 'Buffets'

    expect(page).to have_content 'Não há Buffets disponíveis no momento.'
  end
end