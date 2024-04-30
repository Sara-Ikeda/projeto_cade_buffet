class Event < ApplicationRecord
  belongs_to :buffet
  has_many :prices
  has_many :orders

  validates :name, :event_description, :minimum_of_people,
    :maximum_of_people, :duration, :menu, presence: true

  enum alcoholic_drink: { unprovided: 0, provided: 1 }, _prefix: :alcoholic_drink
  enum ornamentation: { unprovided: 0, provided: 1 }, _prefix: :ornamentation
  enum valet: { unprovided: 0, provided: 1 }, _prefix: :valet
  enum locality: { only_on_site: 0, of_choice: 1 }, _prefix: :locality

  def available_days?
    available_days = []
    available_days << 'Fim de Semana' if !self.prices.where(weekday: 'Fim de Semana').exists?
    available_days << 'Dias Úteis' if !self.prices.where(weekday: 'Dias Úteis').exists?
    available_days.empty? ? false : available_days;
  end
end
