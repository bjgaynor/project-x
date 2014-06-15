class ListingsController < ApplicationController
  # include ApplicationHelper

  def index
    @listing = Listing.new
  end

  def create
    begin
    @listing = Listing.create(listing_params)
    @search_data = Rubillow::PropertyDetails.deep_search_results({ :address => @listing.address, :citystatezip => @listing.city_state_zip, :rentzestimate => true })
    @listing.update_attributes(zpid: @search_data.zpid, rent_zestimate: @search_data.rent_zestimate, homedetail_links: @search_data.links)
    @zestimate_data = Rubillow::HomeValuation.zestimate({ :zpid => @search_data.zpid })
    @listing.update_attributes(zestimate: @zestimate_data.price) #, forecast_percentage: @zestimate_data.percentile)
    rescue => e
      render :error
      return
    else
    render :create
    end
  end

  def upload
    # ListingImporter.new(params[:listing][:excel_file].path, :extension => :xls)
    # ListingImporter.new
    #('/Users/apprentice/Downloads/sheet.xls') #, :extension => :xls)

    #(params["listing"]["excel_file"].path, :extension => :xlsx)
    # importer.import(spreadsheet_path, :extension => :xlsx)
    # render :upload
  end

  private

  def listing_params
    params.require(:listing).permit(:address, :city_state_zip)
  end

end