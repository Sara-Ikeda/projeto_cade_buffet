class Address < ApplicationRecord
  validates :street, :number, :city, :state, :zip, presence: true

  def path
    district? ? "#{street}, #{number}. Bairro: #{district}" : "#{street}, #{number}"
  end
end
