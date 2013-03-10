# == Schema Information
#
# Table name: presentations
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  area_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  description        :text
#  guest_limit        :integer
#  presentation_date  :datetime
#  corporation        :string(255)
#  canceled           :boolean          default(FALSE)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Presentation < ActiveRecord::Base
  attr_accessible :name, :area_id, :presentation_date, :guest_limit, :description, :corporation, :image

  validates_presence_of :name, :guest_limit, :presentation_date, :corporation, :area

  has_many :participations, :dependent => :destroy
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

  def with_prefix
    if canceled
      "[avlyst] #{self.name}"
    else
      self.name
    end
  end

  has_many :users,   :through => :participations, :source => :user,   :conditions => "participations.participle_type = 'User'"
  has_many :members, :through => :participations, :source => :member, :conditions => "participations.participle_type = 'Member'"

  def participants
    users + members
  end
end
