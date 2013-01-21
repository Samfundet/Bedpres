class Notification < ActiveRecord::Base
  attr_accessible :descritpion, :user_id, :presentation_id 
  belongs_to :user, :dependent => :destroy
  belongs_to :presentation, :dependent => :destroy

end
