# == Schema Information
#
# Table name: presentations
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  area_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  guest_limit       :integer
#  presentation_date :datetime
#  corporation       :string(255)
#

class Presentation < ActiveRecord::Base
  attr_accessible :name, :area_id, :presentation_date, :guest_limit, :description, :corporation

  validates_presence_of :name, :guest_limit, :presentation_date, :corporation, :area
  validates :guest_limit, :numericality => { :greater_than => 0}
  validates :presentation_date, :date => { :after => Proc.new { Time.now } }, :if => :presentation_date_changed?

  belongs_to :area

  scope :upcoming, where("presentation_date >= ?", Time.now).order("presentation_date ASC")
  scope :past, where("presentation_date < ?", Time.now).order("presentation_date DESC")
end
