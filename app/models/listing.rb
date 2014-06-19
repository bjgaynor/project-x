class Listing < ActiveRecord::Base
  serialize :rent_zestimate, Hash
  serialize :homedetail_links, Hash

  # validates_uniqueness_of :zpid
  # validates_exclusion_of :address, :in => "address"
  # validates_exclusion_of :city_state_zip, :in => "city, state, and zip"
  validates :address, presence: true
  validates :city_state_zip, presence: true
end