class AddSizeSoldSecurityPackageBedroomsBathroomsToListings < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :size, :integer
    add_column :listings, :sold, :boolean, default: false
    add_column :listings, :security_package, :boolean, default: true
    add_column :listings, :bedroom, :integer
    add_column :listings, :bathroom, :integer
  end
end
