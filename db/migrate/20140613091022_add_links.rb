class AddLinks < ActiveRecord::Migration
  def change
    add_column :listings, :homedetail_links, :text
  end
end
