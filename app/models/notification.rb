# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  descritpion     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  presentation_id :integer
#

class Notification < ActiveRecord::Base
  attr_accessible :descritpion, :notifiable, :presentation_id
  belongs_to :notifiable, :polymorphic => true
  belongs_to :presentation

  validates_presence_of :user_id, :user, :presentation_id, :presentation, :descritpion
end
