class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :buffet
  belongs_to :event
  has_one :order_budget

  validates :date,  :number_of_guests, :other_details, :code, presence: true
  validates :code, uniqueness: true
  validates :address, presence: true, if: :locality
  before_validation :generate_code, on: :create

  enum status: { pending: 0, approved: 1, confirmed: 3, canceled: 7 }

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def locality
    self.event.locality_of_choice?
  end

end
