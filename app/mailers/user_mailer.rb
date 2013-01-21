# encoding: UTF-8

class UserMailer < ActionMailer::Base
  default :from => "bedpres@samfundet.no"
  layout "email"

  def forgot_password(user, hash)
    @user = user
    @hash = hash
    mail :to => user.email, :subject => "Glemt passord?", :css => :email
  end

  def verify_account(user, hash)
    @user = user
    @hash = hash
    mail :to => user.email, :subject => "Verifisering av konto på bedpres.samfundet.no", :css => :email
  end

end
