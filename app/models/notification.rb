class Notification < ActiveRecord::Base
  attr_accessible :descritpion, :user_id, :presentation_id 
  belongs_to :user
  belongs_to :presentation

end
