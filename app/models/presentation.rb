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
#  canceled          :boolean          default(FALSE)
#

class Presentation < ActiveRecord::Base
  attr_accessible :name, :area_id, :presentation_date, :guest_limit, :description, :corporation, :image

  validates_presence_of :name, :guest_limit, :presentation_date, :corporation, :area

  has_many :participations, :dependent => :destroy
  has_many :users, :through => :participations
  has_attached_file :image, 
              :styles => { :banner => "970x300^" },
              :default_url => '/assets/placeholder.jpg'

  validates :guest_limit, :numericality => { :greater_than => 0}
  validates :presentation_date, :date => { :after => Proc.new { Time.zone.now } }, :if => :presentation_date_changed?
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  belongs_to :area

  scope :upcoming, lambda { where("presentation_date >= ?", Time.zone.now).order("presentation_date ASC") }
  scope :past, lambda { where("presentation_date < ?", Time.zone.now).order("presentation_date DESC") }

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def name
    if canceled
      "[avlyst] #{super}"
    else
      super
    end
  end
end
