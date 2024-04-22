class Event < ApplicationRecord
  belongs_to :buffet
  has_many :prices

  validates :name, :event_description, :minimum_of_people,
    :maximum_of_people, :duration, :menu, presence: true

  enum alcoholic_drink: { unprovided: 0, provided: 1 }, _prefix: :alcoholic_drink
  enum ornamentation: { unprovided: 0, provided: 1 }, _prefix: :ornamentation
  enum valet: { unprovided: 0, provided: 1 }, _prefix: :valet
  enum locality: { only_on_site: 0, of_choice: 1 }, _prefix: :locality

  # private

  def newPrice
    self.prices << Price.new
  end
end
