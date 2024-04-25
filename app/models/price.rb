class Price < ApplicationRecord
  belongs_to :event

  validates :minimum_cost, :add_cost_by_person, :add_cost_by_hour, :weekday, presence: true
end
