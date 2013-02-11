# == Schema Information
#
# Table name: password_recoveries
#
#  id            :integer          not null, primary key
#  recovery_hash :string(255)
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PasswordRecovery < ActiveRecord::Base
  attr_accessible :user, :recovery_hash
  belongs_to :user, :dependent => :destroy
  validates_presence_of :user_id, :user, :recovery_hash
end
