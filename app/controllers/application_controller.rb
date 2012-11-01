# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user_for_model_layer_access_control

  def current_user
    begin
      if session[:member_id]
        @current_user ||= Member.find(session[:member_id])
      elsif session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    rescue
      @current_user = nil
    end
  end

  def permission_denied 
    flash[:error] = "Du har ikke rettigheter til å gjøre dette."
    redirect_to login_path
  end

  protected

    def set_current_user_for_model_layer_access_control
      Authorization.current_user = current_user
    end

end
