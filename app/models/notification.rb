# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  descritpion     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  presentation_id :integer
#  notifiable_type :string(255)
#  notifiable_id   :integer
#

class Notification < ActiveRecord::Base
  attr_accessible :descritpion, :notifiable, :presentation_id
  belongs_to :notifiable, :polymorphic => true
  belongs_to :presentation

  validates_presence_of :notifiable_id, :notifiable_type, :notifiable, :presentation_id, :presentation, :descritpion
end
