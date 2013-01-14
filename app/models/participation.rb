# == Schema Information
#
# Table name: participations
#
#  id              :integer          not null, primary key
#  presentation_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  participle_type :string(255)
#  participle_id   :integer
#

class Participation < ActiveRecord::Base
  attr_accessible :participle, :presentation
  belongs_to :participle, :polymorphic => true
  belongs_to :presentation

  validates_presence_of :presentation_id, :participle_type, :participle_id
  validates_associated :participle, :presentation

end
