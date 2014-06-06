class CreateListing < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.string :street_name
      t.string :zip_code
      t.string :zestimate
      t.string :rent_estimate
      t.string :forecast_percentage
      t.timestamps
    end
  end
end
