class AddIndexToListings < ActiveRecord::Migration
  def change
     change_column :listings, :homedetail_links, :string
     change_column :listings, :rent_zestimate, :string
     add_index :listings, :import_id
     add_index :listings, :address
     add_index :listings, :city_state_zip
     add_index :listings, :zpid
     add_index :listings, :homedetail_links
     rename_column :listings, :homedetail_links, :homepage
  end
end
