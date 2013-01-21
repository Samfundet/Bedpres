class Notification < ActiveRecord::Base
  attr_accessible :descritpion, :notifiable, :presentation_id
  belongs_to :notifiable, :polymorphic => true
  belongs_to :presentation

end
