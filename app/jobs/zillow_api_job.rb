class ZillowApiJob
  include SuckerPunch::Job
  workers 2

  def perform(listing_id, search_data, zestimate_data)
    ActiveRecord::Base.connection_pool.with_connection do
      listing = ::Listing.find(listing_id)
      listing.update_attributes(zpid: search_data.zpid, zestimate: zestimate_data.price, rent_zestimate: search_data.rent_zestimate[:price]) #, homepage: @search_data.links)
    end
  end
end