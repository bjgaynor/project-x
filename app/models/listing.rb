class Listing < ActiveRecord::Base
  belongs_to :import

  # serialize :rent_zestimate, Hash
  serialize :homedetail_links, Hash

  scope :recent, ->{order(created_at: :desc)}

  # validates_uniqueness_of :zpid
  validates :address, presence: true
  validates :city_state_zip, presence: true
end