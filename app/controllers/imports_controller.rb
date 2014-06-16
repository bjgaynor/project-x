class ImportsController < ApplicationController

  def index
    @import = Import.new
  end

  def create
    begin
    @import = Import.create(import_params)
    @@spreadsheet = Roo::Excel.new("#{@import.spreadsheet.path}")
    # @@spreadsheet = Roo::Excelx.new("#{@import.spreadsheet.path}") #BUGFIX
    rescue => e
      render :error
      return
    else
    render :create
    end
  end

  def upload

  end

private

  def import_params
    params.require(:import).permit(:spreadsheet)
  end

end