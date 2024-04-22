class Event < ApplicationRecord
  belongs_to :buffet

  enum alcoholic_drink: { unprovided: 0, provided: 1 }, _prefix: :alcoholic_drink
  enum ornamentation: { unprovided: 0, provided: 1 }, _prefix: :ornamentation
  enum valet: { unprovided: 0, provided: 1 }, _prefix: :valet
  enum locality: { only_on_site: 0, of_choice: 1 }, _prefix: :locality
end
