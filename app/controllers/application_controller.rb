# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user_for_model_layer_access_control

  def current_user
    begin
      if session[:member_id]
        @current_user ||= Member.find(session[:member_id])
      #elsif session[:applicant_id] to be implemented with normal user login
      #  @current_user ||= Applicant.find(session[:applicant_id])
      end
    rescue
      @current_user = nil
    end
  end

  def permission_denied 
    flash[:failure] = "Du må logge inn for å gjøre dette"
    #redirect_to :back
    #rescue ActionController::RedirectBackError
    redirect_to login_path
  end

  protected

    def set_current_user_for_model_layer_access_control
      Authorization.current_user = current_user
    end

end
