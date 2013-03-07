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
  include PasswordResetHelper

  attr_accessor :password, :password_confirmation, :old_password
  attr_accessible :firstname, :surname, :email, :password, :password_confirmation, :old_password

  has_many :participations, :dependent => :destroy
  has_many :presentations, :through => :participations
  has_many :notifications

  validates_presence_of :firstname, :surname, :email

  validates :email, :email_format => {:message => 'ikke gyldig adresse'}, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 6}, :if => :password_changed?
  validates :password_confirmation, :presence => true, :if => :password_changed?
  validate :validate_old_password, :if => (Proc.new do |user|
    user.password_changed? && !user.new_record?
  end)

  has_many :password_recoveries

  before_validation :downcase_email
  before_save :hash_new_password, :if => :password_changed?
  after_create :verify_account, :unless => :verified

  def password_changed?
    !(@password.nil? or @password.blank?) || !(@password_confirmation.nil? or @password_confirmation.blank?)
  end

  def skip_email_validation!
    self.verified = true
  end

  def verify_account
    UserMailer.verify_account(self, create_verification_hash).deliver
  end

  def verify!(hash)
    if create_verification_hash == hash
      self.verified = true
      self.save
    else
      raise HashMismatchError
    end
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

  def forgot_password!
    if can_recover_password?
      hash = create_recovery_hash

      PasswordRecovery.create!(
          :user => self,
          :recovery_hash => hash
      )

      UserMailer.forgot_password(self, hash).deliver!
    else
      raise MaxAttemptsReachedError
    end
  end

  def reset_password!(hash, password)
    if check_hash(hash)
      @password = password
      save :validate => false
      password_recoveries.delete_all
    else
      raise HashMismatchError
    end
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
    email.downcase! if email
  end

  def validate_old_password
    unless self.class.authenticate(email, old_password)
      errors.add :old_password, "feil passord"
    end
  end
end
