class ApplicationController < ActionController::Base
  before_filter :set_current_user
  protect_from_forgery

  def set_current_user
    unless session[:member_id].nil?
      @current_user = Member.find session[:member_id]
    end
  end
end
