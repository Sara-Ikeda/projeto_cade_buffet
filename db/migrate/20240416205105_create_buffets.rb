class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :trade_name
      t.string :company_name
      t.string :registration_number
      t.string :telephone
      t.string :email
      t.references :address, null: false, foreign_key: true
      t.string :description
      t.string :payment_types

      t.timestamps
    end
  end
end
