# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
owner = Owner.create!(email: 'buffet1@email.com', password: 'password')
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
Price.create!(minimum_cost: 5000, add_cost_by_person: 100,
          add_cost_by_hour: 500 ,weekday: 'Dias Úteis', event: event_a)
Price.create!(minimum_cost: 8000, add_cost_by_person: 150,
          add_cost_by_hour: 500 ,weekday: 'Fim de Semana', event: event_a)
event_b = Event.create!(name: 'Festa de Bodas', event_description: 
          'A festa do seu jeito.', minimum_of_people: 50, maximum_of_people: 150,
          duration: 120, menu: 'Bolo. Jantar.',
          alcoholic_drink: 1, ornamentation: 1, valet: 0, locality: 0, buffet: buffet)
Price.create!(minimum_cost: 2000, add_cost_by_person: 80,
          add_cost_by_hour: 200 ,weekday: 'Dias Úteis', event: event_b)
Price.create!(minimum_cost: 4000, add_cost_by_person: 100,
          add_cost_by_hour: 300 ,weekday: 'Fim de Semana', event: event_b)

second_owner = Owner.create!(email: 'buffet2@gmail.com', password: 'password')
second_address = Address.create!(street: 'Avenida 9 de Julho', number: 150, district: 'Jardim Paulista',
                  city: 'São Paulo', state: 'SP', zip: '01153000')
second_buffet = Buffet.create!(trade_name: 'Doces e Salgados SP', company_name: 'Doces e Salgados LA',
                registration_number: '02946813000245', telephone: '55985943684',
                email: 'sac@docesesalgados.com', address: second_address, owner: second_owner,
                description: 'Doces e Salgados para sua festa', payment_types: 'Dinheiro e PIX')
second_event_a = Event.create!(name: 'Festa de Aniversário', event_description: 
                'Para todas as idades.', minimum_of_people: 200, maximum_of_people: 250,
                duration: 240, menu: 'Bolo, brigadeiros, beijinhos. Esfiras de carne, frango, queijo, etc. Coxinhas.',
                alcoholic_drink: 0, ornamentation: 1, valet: 1, locality: 0, buffet: second_buffet)
Price.create!(minimum_cost: 3000, add_cost_by_person: 50,
                add_cost_by_hour: 100 ,weekday: 'Dias Úteis', event: second_event_a)
Price.create!(minimum_cost: 3500, add_cost_by_person: 70,
                add_cost_by_hour: 90 ,weekday: 'Fim de Semana', event: second_event_a)

third_owner = Owner.create!(email: 'buffet3@email.com', password: 'password')
third_address = Address.create!(street: 'Avenida Central', number: 99, district: 'Itaipu',
                          city: 'Niterói', state: 'RJ', zip: '85875000')
Buffet.create!(trade_name: 'Doces do RJ', company_name: 'Doces LTDA',
              registration_number: '85967518000168', telephone: '55986475932',
              email: 'contato@doces.com', address: third_address, owner: third_owner,
              description: 'Sua festa doce', payment_types: 'Débito/PIX')