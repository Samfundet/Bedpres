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
  belongs_to :user
  belongs_to :presentation

  validates_presence_of :user_id, :presentation_id
  validates_associated :user, :presentation

end
