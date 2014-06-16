class ImportsController < ApplicationController

  def index
    @import = Import.new
  end

  def create
    @import = Import.create(import_params)
    puts @import.spreadsheet.path
    render :create
  end

  def upload

  end

private

  def import_params
    params.require(:import).permit(:spreadsheet)
  end

end