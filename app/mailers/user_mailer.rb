class UserMailer < ActionMailer::Base
  default :from => "bedpres@samfundet.no"
  layout "email"

  def forgot_password(user, hash)
    @user = user
    @hash = hash
    mail :to => user.email, :subject => "Glemt passord?", :css => :email
  end
end
