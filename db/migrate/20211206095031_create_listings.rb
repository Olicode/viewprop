class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :address
      t.text :description
      t.integer :price
      t.boolean :negotiable
      t.boolean :instant_booking

      t.timestamps
    end
  end
end
