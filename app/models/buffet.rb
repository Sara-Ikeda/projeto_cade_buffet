class Buffet < ApplicationRecord
  belongs_to :address, validate: true
  belongs_to :owner

  validates :trade_name, :company_name, :registration_number, :telephone,
            :email, :description, :payment_types, presence: true

  validates :registration_number, uniqueness: true

  def contact
    "#{telephone} | #{email}"
  end
end