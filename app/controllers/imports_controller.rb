class ImportsController < ApplicationController

  def index
    @import = Import.new
  end

  def create
    begin
    @import = Import.create(import_params)
    # @@spreadsheet = Roo::Excelx.new("#{@import.spreadsheet.path}") #BUGFIX
    rescue => e
      render :error
      return
    else
    render :create
    end
  end

  #refactor the shit out of
  def upload
    # begin
    @listings = []
    @spreadsheet = Roo::Spreadsheet.open("#{Import.last.spreadsheet.path}")
      @spreadsheet.each do |row|
        @listing = Listing.create(address: row[0], city_state_zip: row[1])
        if @listing.address == "address"
          @listing.destroy
        else
          @search_data = Rubillow::PropertyDetails.deep_search_results({ :address => @listing.address, :citystatezip => @listing.city_state_zip, :rentzestimate => true })
          @zestimate_data = Rubillow::HomeValuation.zestimate({ :zpid => @search_data.zpid })
          @listing.update_attributes(zpid: @search_data.zpid, zestimate: @zestimate_data.price, rent_zestimate: @search_data.rent_zestimate[:price], homedetail_links: @search_data.links)
          mechanize = Mechanize.new do |agent|
          agent.follow_meta_refresh = true
          agent.redirect_ok = true
          end
        page = mechanize.get("#{@listing.homedetail_links.first[1]}") do |home_page|
        login_page = mechanize.click(home_page.link_with(:text => 'Sign In'))
        my_page = login_page.form_with(:id => 'loginForm') do |form|
          email_field = form.field_with(:id => 'email')
          email_field.value = 'Bjgaynor@gmail.com'
          password_field = form.field_with(:id => 'password')
          password_field.value = 'b050295g'
          next_page = mechanize.submit(form)
          @listing.update_attributes(forecast_percentage: next_page.search('.zest-forecast-change-percent').inner_text)
          @listings << @listing
              end
            end
          end
        end
      render :upload
    end

private

  def import_params
    params.require(:import).permit(:spreadsheet)
  end

end