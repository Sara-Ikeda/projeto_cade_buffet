class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :buffet, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.date :date
      t.integer :number_of_guests
      t.string :other_details
      t.string :code
      t.integer :status, default: 0
      t.string :address

      t.timestamps
    end
  end
end
