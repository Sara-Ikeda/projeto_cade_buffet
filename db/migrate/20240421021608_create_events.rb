class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_description
      t.integer :minimum_of_people
      t.integer :maximum_of_people
      t.integer :duration
      t.string :menu
      t.integer :alcoholic_drink, default: 0
      t.integer :ornamentation, default: 0
      t.integer :valet, default: 0
      t.integer :locality, default: 0
      t.references :buffet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
