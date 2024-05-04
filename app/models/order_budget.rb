class OrderBudget < ApplicationRecord
  belongs_to :order

  validates :deadline, :payment_options, presence: true
  validates :rate_value, :rate_description, presence: true, unless: :have_rate?

  enum rate: { none: 0, increase: 4, discount: 8 }, _prefix: :rate

  after_initialize :calculate_standard_value
  
  def calculate_standard_value
    return self.standard_value = 0 unless order.present?
    if self.order.date.on_weekday?
      price = self.order.event.prices.find_by!(weekday: 'Dias Úteis')
    else
      price = self.order.event.prices.find_by!(weekday: 'Fim de Semana')
    end
    if self.order.number_of_guests > self.order.event.minimum_of_people
      self.standard_value = (self.order.number_of_guests - self.order.event.minimum_of_people
                      )*price.add_cost_by_person + price.minimum_cost
    else
      self.standard_value = price.minimum_cost
    end
  end

  def human_attribute_rates
    Hash[OrderBudget.rates.map{|rate, key| [rate, I18n.t("#{rate}")]}]
  end

  def have_rate?
    self.rate_none?
  end
end