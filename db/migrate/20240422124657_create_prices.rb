class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.integer :minimum_cost
      t.integer :add_cost_by_person
      t.integer :add_cost_by_hour
      t.string :weekday
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
