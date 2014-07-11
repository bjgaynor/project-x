class RemoveImportId < ActiveRecord::Migration
  def change
    remove_column :listings, :import_id
  end
end
