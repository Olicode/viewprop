class RemoveNegotiableFromListing < ActiveRecord::Migration[6.1]
  def change
    remove_column :listings, :negotiable, :boolean
  end
end
