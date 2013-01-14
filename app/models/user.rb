# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)
#  firstname        :string(255)
#  surname          :string(255)
#  hashed_password  :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  verified         :boolean          default(FALSE)
#  unverified_email :string(255)
#

class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :old_password
  attr_accessible :firstname, :surname, :email, :password, :password_confirmation, :old_password


  has_many :participations, :dependent => :destroy
  has_many :presentations, :through => :participations

  validates_presence_of :firstname, :surname, :email

  validates :email, :email_format => {:message => 'ikke gyldig adresse'}, :presence => true, :uniqueness => true
  validates :password, :presence => true, :confirmation => true, :length => {:minimum => 6}, :if => :password_changed?
  validates :password_confirmation, :presence => true, :if => :password_changed?

  has_many :password_recoveries

  before_validation :downcase_email
  before_save :hash_new_password, :if => :password_changed?
  after_create :verify_account

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
    self.hashed_password = BCrypt::Password.create(password)
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
      return user if user &&
        BCrypt::Password.new(user.hashed_password) == password &&
        user.verified
    end
  end

  private

  def downcase_email
      email.downcase!
  end

end
