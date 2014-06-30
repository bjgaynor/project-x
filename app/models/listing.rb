class Listing < ActiveRecord::Base
  scope :recent, ->{order(created_at: :desc)}

  # validates_uniqueness_of :zpid

  validates :address, presence: true
  validates :city_state_zip, presence: true
end