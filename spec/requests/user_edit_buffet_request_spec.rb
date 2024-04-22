require 'rails_helper'

describe 'Usuário edita um buffet' do
  it 'e não é dono' do
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
    patch(buffet_path(buffet.id), params: { buffet: {address_id: 2}})

    expect(response).to redirect_to root_path
  end
end