class Customer < ApplicationRecord
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :cpf, presence: true
  validates :cpf, uniqueness: true, length: { is: 11 }, numericality: {only_integer: true}

  before_validation :cpf_valid?, on: :create

  def cpf_valid?
    errors.add(:cpf, :invalid, message: "tem que ser válido") unless CPF.valid?(self.cpf)
  end
end