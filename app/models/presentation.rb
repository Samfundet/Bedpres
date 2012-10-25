class Presentation < ActiveRecord::Base
  attr_accessible :name, :area_id

  validates_presence_of :name

  belongs_to :area
end
