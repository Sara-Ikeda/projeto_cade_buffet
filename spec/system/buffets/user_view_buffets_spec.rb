require 'rails_helper'

describe 'Usuário vê todos os Buffets' do
  it 'na tela inicial' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                              city: 'São Paulo', state: 'SP', zip: '01153000')
    Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                   registration_number: '56862478000652', telephone: '55961524798',
                   email: 'noivos@contato.com', address: address, owner: owner,
                   description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
    
    other_owner = Owner.create!(email: 'ikeda@email.com', password: '123654')
    other_address = Address.create!(street: 'Avenida Central', number: 99, district: 'Itaipu',
                              city: 'Niterói', state: 'RJ', zip: '85875000')
    Buffet.create!(trade_name: 'Doces e Salgados RJ', company_name: 'Doces e Salgados LA',
                  registration_number: '56868423000652', telephone: '55961698471',
                  email: 'doces@salgados.com', address: other_address, owner: other_owner,
                  description: 'Doces e salgados para a sua festa', payment_types: 'PIX')

    visit root_path

    expect(page).to have_content 'Gourmet dos Noivos'
    expect(page).to have_content 'São Paulo/SP'
    expect(page).to have_content 'Doces e Salgados RJ'
    expect(page).to have_content 'Niterói/RJ'
  end

  it 'mas não há buffets cadastrados' do
    visit root_path

    expect(page).to have_content 'Não há Buffets disponíveis no momento.'
  end
end