class Listing < ActiveRecord::Base
  validates :address, presence: true
  validates :street_name, presence: true
  validates :zip_code, presence: true
end