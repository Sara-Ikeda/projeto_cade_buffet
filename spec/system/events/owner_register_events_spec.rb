# require 'rails_helper'

# describe 'Dono do Buffet adiciona evento' do
#   it 'a partir da página do seu buffet' do
#     owner = Owner.create!(email: 'sara@email.com', password: 'password')
#     address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
#               city: 'São Paulo', state: 'SP', zip: '01153000')
#     buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
#               registration_number: '56862478000652', telephone: '55961524798',
#               email: 'noivos@contato.com', address: address, owner: owner,
#               description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')

#     login_as(owner)
#     visit root_path
#     click_on 'Meu Buffet'

#     expect(page).to have_button 'Adiocionar Evento'
#   end
# end
