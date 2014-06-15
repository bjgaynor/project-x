class AddSpreadsheetToImport < ActiveRecord::Migration
  def change
    add_attachment :imports, :spreadsheet
  end
end
