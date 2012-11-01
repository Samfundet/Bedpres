# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  firstname       :string(255)
#  surname         :string(255)
#  hashed_password :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

  attr_accessor :password, :password_confirmation
  attr_accessible :firstname, :surname, :email, :password, :password_confirmation

  validates_presence_of :firstname, :surname, :email

  validates :email, :email_format => {:message => 'Invalid email'}, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 6}

  validates_presence_of :password_confirmation

  before_save do |user|
    hash_new_password
    email.downcase!
  end

  def role_symbols
    [:user]
  end

  def hash_new_password
    self.hashed_password = BCrypt::Password.create(password)
  end

  class << self
    def authenticate(email, password)
      user = find_by_email(email.downcase)
      return user if user &&
        BCrypt::Password.new(user.hashed_password) == password
      end
    end

  private
    def lowercase_email
      email.downcase!
    end

end
