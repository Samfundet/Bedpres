# == Schema Information
#
# Table name: presentations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  guest_limit :integer
#  date        :datetime
#

class Presentation < ActiveRecord::Base
  attr_accessible :name, :area_id, :presentation_date, :guest_limit, :description

  validates_presence_of :name, :guest_limit, :presentation_date
  validates :guest_limit, :numericality => { :greater_than => 0}
  validates :presentation_date, :date => { :after => Time.now}

  belongs_to :area
end
