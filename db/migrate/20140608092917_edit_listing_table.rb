class EditListingTable < ActiveRecord::Migration
  def change
    add_column :listings, :zpid, :string
    remove_column :listings, :street_name
    remove_column :listings, :zip_code
    add_column :listings, :city_state_zip, :string
  end
end
