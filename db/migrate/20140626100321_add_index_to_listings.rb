class AddIndexToListings < ActiveRecord::Migration
  def change
    add_column :listings, :import_id, :integer
    add_index :listings, :import_id
    add_index :listings, :address
    add_index :listings, :city_state_zip
    add_index :listings, :zpid
    add_index :listings, :homedetail_links
  end
end
