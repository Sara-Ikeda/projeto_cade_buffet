class CreateOrderBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :order_budgets do |t|
      t.references :order, null: false, foreign_key: true
      t.integer :standard_value
      t.date :deadline
      t.integer :rate, default: 0
      t.integer :rate_value
      t.string :rate_description
      t.string :payment_options

      t.timestamps
    end
  end
end
