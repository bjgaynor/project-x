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

  def upload
    @spreadsheet = Roo::Spreadsheet.open("#{Import.last.spreadsheet.path}")
    puts @spreadsheet.sheet(0).row(3) #array of the third row
    puts @spreadsheet.sheet(0).column(3) #array of the third column
    # potentially make a class method of listing or import to iterate through each row of two columns and create listings
    # potentially create a failsafe using the first row, as in *if first row != [address, city_state_zip] no go*
    # puts "*********************************"
    # puts @@spreadsheet.parse(:header_search => ['UPC*SKU','ATS*\sATP\s*QTY$'])
    render :upload
  end

private

  def import_params
    params.require(:import).permit(:spreadsheet)
  end

end