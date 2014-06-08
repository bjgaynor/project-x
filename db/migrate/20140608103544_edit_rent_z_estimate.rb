class EditRentZEstimate < ActiveRecord::Migration
  def change
    remove_column :listings, :rent_estimate
    add_column :listings, :rent_zestimate, :text
  end
end
