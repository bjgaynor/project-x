class Import < ActiveRecord::Base
  has_attached_file :spreadsheet #, :default_url => "/assets/spreadsheets"
  validates_attachment_content_type :spreadsheet, :content_type => "application/vnd.ms-excel"
  validates :spreadsheet, :attachment_presence => true
end

