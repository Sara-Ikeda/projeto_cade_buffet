# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
owner = Owner.create!(email: 'sara@email.com', password: 'password')
other_owner = Owner.create!(email: 'ikeda@gmail.com', password: '112358')

address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
                          city: 'São Paulo', state: 'SP', zip: '01153000')
other_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                                city: 'São Paulo', state: 'SP', zip: '01153000')

Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
                    registration_number: '56862478000652', telephone: '55961524798',
                    email: 'noivos@contato.com', address: address, owner: owner,
                    description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
Buffet.create!(trade_name: 'Doces & Salgados', company_name: 'Doces e Salgados LA',
                    registration_number: '02946813000245', telephone: '55985943684',
                    email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                    description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')