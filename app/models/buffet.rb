class Buffet < ApplicationRecord
  belongs_to :address

  validates :trade_name, :company_name, :registration_number, :email, 
            :description, :payment_types, presence: true

  def contact
    telephone? ? "#{telephone} | #{email}" : "#{email}"
  end
end
