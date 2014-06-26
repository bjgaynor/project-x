class Import < ActiveRecord::Base
  has_attached_file :spreadsheet
  has_many :listings, :dependent => :destroy
  validates_attachment_content_type :spreadsheet, :content_type => 'application/vnd.ms-excel'
  validates :spreadsheet, :attachment_presence => true
end

