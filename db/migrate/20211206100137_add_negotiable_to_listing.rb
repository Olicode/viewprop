class AddNegotiableToListing < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :negotiable, :boolean, default: false
  end
end
