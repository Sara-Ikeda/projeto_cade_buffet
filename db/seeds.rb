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
address = Address.create!(street: 'Av Paulista', number: 50, district: 'Bela Vista',
            city: 'São Paulo', state: 'SP', zip: '01153000')
buffet = Buffet.create!(trade_name: 'Gourmet dos Noivos', company_name: 'Buffet Gourmet LTDA',
          registration_number: '56862478000652', telephone: '55961524798',
          email: 'noivos@contato.com', address: address, owner: owner,
          description: 'Buffet especializado em casamento', payment_types: 'Cartão Débito/Crédito')
event_a = Event.create!(name: 'Festa de Casamento', event_description: 
          'Todos os serviços para o seu casamento perfeito.', minimum_of_people: 100, maximum_of_people: 250,
          duration: 180, menu: 'Bolo, bem-casadinhos, salgados. Estrogonofe, Carne ao molho madeira.',
          alcoholic_drink: 1, ornamentation: 1, valet: 1, locality: 0, buffet: buffet)
price = Price.create!(minimum_cost: 10000, add_cost_by_person: 200,
          add_cost_by_hour: 300 ,weekday: 'Dias Úteis', event: event_a)
event_b = Event.create!(name: 'Festa de Bodas', event_description: 
          'A festa do seu jeito.', minimum_of_people: 50, maximum_of_people: 150,
          duration: 120, menu: 'Bolo. Jantar.',
          alcoholic_drink: 1, ornamentation: 1, valet: 0, locality: 0, buffet: buffet)

other_owner = Owner.create!(email: 'ikeda@gmail.com', password: '112358')
other_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
other_buffet = Buffet.create!(trade_name: 'Doces & Salgados SP', company_name: 'Doces e Salgados LA',
                registration_number: '02946813000245', telephone: '55985943684',
                email: 'sac@docesesalgados.com', address: other_address, owner: other_owner,
                description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')

third_owner = Owner.create!(email: 'hime@email.com', password: '135711')
third_address = Address.create!(street: 'Avenida Central', number: 99, district: 'Itaipu',
                          city: 'Niterói', state: 'RJ', zip: '85875000')
Buffet.create!(trade_name: 'Doces do RJ', company_name: 'Doces LTDA',
              registration_number: '85967518000168', telephone: '55986475932',
              email: 'contato@doces.com', address: third_address, owner: third_owner,
              description: 'Sua festa doce', payment_types: 'Débito/PIX')