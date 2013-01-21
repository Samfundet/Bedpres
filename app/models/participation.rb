# == Schema Information
#
# Table name: participations
#
#  id              :integer          not null, primary key
#  presentation_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Participation < ActiveRecord::Base
  attr_accessible :user, :presentation
  belongs_to :user, :dependent => :destroy
  belongs_to :presentation, :dependent => :destroy

  validates_presence_of :user_id, :user, :presentation_id, :presentation
end
