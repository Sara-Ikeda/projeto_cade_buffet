class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :buffet
  belongs_to :event
  has_one :order_budget

  validates :date,  :number_of_guests, :other_details, :code, presence: true
  validates :code, uniqueness: true
  validates :address, presence: true, if: :locality?
  before_validation :generate_code, on: :create

  enum status: { pending: 0, approved: 1, confirmed: 3, canceled: 7 }

  after_find :check_current_date_is_before_the_deadline

  private

  def check_current_date_is_before_the_deadline
    if self.order_budget.present?
      self.canceled! if self.order_budget.deadline < Date.today
    end
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def locality?
    self.event.locality_of_choice?
  end

end
