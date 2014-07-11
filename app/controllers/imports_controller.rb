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

  #timeout issue
  def upload
    @listings = []
    @spreadsheet = Roo::Spreadsheet.open("#{Import.last.spreadsheet.path}")
    render :upload
    @spreadsheet.each do |row|

      @listing = Listing.create(address: row[0], city_state_zip: row[1])
      @search_data = Rubillow::PropertyDetails.deep_search_results({ :address => @listing.address, :citystatezip => @listing.city_state_zip, :rentzestimate => true })
      if @search_data.message[0...5] == "Error"
        @listing.destroy
      else
        @zestimate_data = Rubillow::HomeValuation.zestimate({ :zpid => @search_data.zpid })

        mechanize = Mechanize.new do |agent|
        agent.follow_meta_refresh = true
        agent.redirect_ok = true
        end

        ZillowApiJob.new.async.perform(@listing.id, @search_data, @zestimate_data)
        ForecastScrapeJob.new.async.perform(@listing.id, @search_data, mechanize)
      end
    end
  end

private

  def import_params
    params.require(:import).permit(:spreadsheet)
  end

end