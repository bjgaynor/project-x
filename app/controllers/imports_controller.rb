class ImportsController < ApplicationController

  def index
    @import = Import.new
  end

  def create
    @import = Import.create(import_params)
    if @import.id == nil
      @import.destroy
      render :error
    else
      render :create
    end
  end

  def upload
    @listings = []
    @spreadsheet = Roo::Spreadsheet.open("#{Import.last.spreadsheet.path}")
    render :upload
    @spreadsheet.each do |row|
      @listing = Listing.create(address: row[0], city_state_zip: row[1]) #, import_id: Import.last.id)
      if @listing.address == "address"
        @listing.destroy
      else
        @search_data = Rubillow::PropertyDetails.deep_search_results({ :address => @listing.address, :citystatezip => @listing.city_state_zip, :rentzestimate => true })
        @zestimate_data = Rubillow::HomeValuation.zestimate({ :zpid => @search_data.zpid })
        #TODO put above two lines in zillow_api_job
        @listing.update_attributes(homepage: @search_data.links.first[1])
        ZillowApiJob.new.async.perform(@listing.id, @search_data, @zestimate_data)
        ForecastScrapeJob.new.async.perform(@listing.id)
      end
    end
  end

private

  def import_params
    params.require(:import).permit(:spreadsheet)
  end

end