class ListingsController < ApplicationController

  def index
    @listing = Listing.new
  end

  def create
    begin
    @listing = Listing.create(listing_params)
    @search_data = Rubillow::PropertyDetails.deep_search_results({ :address => @listing.address, :citystatezip => @listing.city_state_zip, :rentzestimate => true })
    @zestimate_data = Rubillow::HomeValuation.zestimate({ :zpid => @search_data.zpid })
    @listing.update_attributes(zpid: @search_data.zpid, zestimate: @zestimate_data.price, rent_zestimate: @search_data.rent_zestimate, homedetail_links: @search_data.links)

    # mechanize = Mechanize.new
    # page = mechanize.get("#{@listing.homedetail_links.first[1]}")
    # puts page.search('.zest-container').inner_text

    # User must log in to see the contents of this container including the Zestimate Forecast

    rescue => e
      render :error
      return
    else
    render :create
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:address, :city_state_zip)
  end

end