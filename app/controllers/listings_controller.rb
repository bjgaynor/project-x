class ListingsController < ApplicationController

  def index
    @listing = Listing.new
  end

  def create
    # @listing = Listing.create(address: params[:address], street_name: params[:street_name], zip_code: params[:zip_code])
    @listing = Listing.create(listing_params)
    @data = Rubillow::HomeValuation.search_results({ :address => @listing.address, :citystatezip => @listing.city_state_zip, :rentzestimate => true })
    @listing.update_attributes(zpid: @data.zpid, rent_zestimate: @data.rent_zestimate)
    render :create
  end

  private

  def listing_params
    params.require(:listing).permit(:address, :city_state_zip)
  end

end