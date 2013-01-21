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
#  verified        :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  extend AccountValidationHelper
  attr_accessor :password, :password_confirmation, :old_password
  attr_accessible :firstname, :surname, :email, :password, :password_confirmation, :old_password

  has_many :participations, :as => :participle, :dependent => :destroy
  has_many :presentations, :through => :participations
  has_many :notifications, :as => :notifiable, :order => "created_at DESC"

  validates_presence_of :firstname, :surname, :email

  validates :email, :email_format => {:message => 'ikke gyldig adresse'}, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 6}, :if => :password_changed?
  validates :password_confirmation, :presence => true, :if => :password_changed?

  has_many :password_recoveries

  before_validation :downcase_email
  before_save :hash_new_password, :if => :password_changed?

  if Rails.env == "production"
    after_create :verify_account
  else
    before_create :set_verified
  end

  def set_verified
    self.verified = true
  end

  def password_changed?
    not @password.nil?
  end

  def verify_account
    UserMailer.verify_account(self, create_verification_hash).deliver
  end

  def role_symbols
    [:user]
  end

  def hash_new_password
    if Rails.env == "production"
      cost = 10
    else
      cost = 1
    end

    self.hashed_password = BCrypt::Password.create(password, :cost => cost)
  end

  def full_name
    "#{firstname} #{surname}"
  end

  def can_recover_password?
    password_recoveries.find(:all, :conditions => ['created_at > ?', Time.now - 1.day]).count < 5
  end

  def create_recovery_hash
    Digest::SHA256.hexdigest(hashed_password + email + Time.now.to_s)
  end

  def create_verification_hash
    Digest::SHA256.hexdigest(attributes.map {|key,value| value}.join)
  end

  def check_hash(hash)
    not password_recoveries.where("recovery_hash = ?", hash).where("created_at > ?", Time.now - 1.hour).empty?
  end

  class << self
    def authenticate(email, password)
      user = find_by_email(email.downcase)
      if user && BCrypt::Password.new(user.hashed_password) == password
        if user.verified?
          user
        else
          raise EmailNotValidatedError
        end
      end
    end
  end

  private

  def downcase_email
      email.downcase!
  end

end
