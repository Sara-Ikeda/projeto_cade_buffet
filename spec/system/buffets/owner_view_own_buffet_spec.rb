require 'rails_helper'

describe 'Dono vê informações do própio Buffet' do
  it 'a partir da página inicial' do
    owner = Owner.create!(email: 'sara@email.com', password: 'password')
    address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
              city: 'São Paulo', state: 'SP', zip: '01153000')
    buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
              registration_number: '56862478000652', telephone: '55961524798',
              email: 'noivos@contato.com', address: address, owner: owner,
              description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

    login_as(owner, scope: :owner)
    visit root_path

    expect(current_path).to eq buffet_path(buffet.id)
    expect(page).to have_content 'Gourmet dos Noivos - 56862478000652'
    expect(page).to have_content 'Buffet especializado em casamento'
    expect(page).to have_content 'Tipos de Pagamento: Cartão Débito/Crédito'
  end
  
  it 'e não vê Buffet de outro dono' do
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

    login_as(other_owner, scope: :owner)
    visit buffet_path(buffet.id)

    expect(current_path).to_not eq buffet_path(buffet.id)
    expect(current_path).to eq buffet_path(other_buffet.id)
    expect(page).to have_content 'Doces e Salgados SP - 56868423000652'
  end
end