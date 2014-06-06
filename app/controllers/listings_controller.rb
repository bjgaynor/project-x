class ListingsController < ApplicationController

  def index
    @listing = Listing.new
  end

  def create
    # @listing = Listing.create(address: params[:address], street_name: params[:street_name], zip_code: params[:zip_code])
    @listing = Listing.create(listing_params)
    puts @listing.inspect
    render :create
  end

  private

  def listing_params
    params.require(:listing).permit(:address, :street_name, :zip_code)
  end

end