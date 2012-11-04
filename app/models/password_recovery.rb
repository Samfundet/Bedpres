class PasswordRecovery < ActiveRecord::Base
  attr_accessible :user, :recovery_hash

  belongs_to :user
end
