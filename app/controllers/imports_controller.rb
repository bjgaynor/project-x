class ImportsController < ApplicationController

  def index
    @import = Import.new
  end

  def create
    begin
    @import = Import.create(import_params)
    @spreadsheet = Roo::Spreadsheet.open("#{@import.spreadsheet.path}")
    @@spreadsheet = Roo::Spreadsheet.open("#{@import.spreadsheet.path}")
    # @@spreadsheet = Roo::Excelx.new("#{@import.spreadsheet.path}") #BUGFIX
    rescue => e
      render :error
      return
    else
    render :create
    end
  end

  def upload
    @@spreadsheet
    puts @@spreadsheet
    puts "*********************************"
    puts @@spreadsheet.sheet(0).row(1)
    puts "*********************************"
    puts @@spreadsheet.parse(:header_search => ['UPC*SKU','ATS*\sATP\s*QTY$'])


  end

private

  def import_params
    params.require(:import).permit(:spreadsheet)
  end

end