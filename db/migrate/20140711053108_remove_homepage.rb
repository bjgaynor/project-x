class RemoveHomepage < ActiveRecord::Migration
  def change
    remove_column :listings, :homepage
  end
end
