class Listing < ActiveRecord::Base
  # serialize :rent_zestimate, Hash
  # serialize :homedetail_links, Hash

  # validates_uniqueness_of :zpid
  validates :address, presence: true
  validates :city_state_zip, presence: true
end