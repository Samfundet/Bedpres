# encoding: UTF-8

class SessionsController < ApplicationController
  filter_access_to :all

  def new; end

  def destroy
    session[:member_id] = nil
    session[:user_id] = nil
    redirect_to root_path
  end

  def create
    if !params[:member].nil?
      logger.debug "trying to login as SamfundetUser"
      session[:user_id] = nil

      member = Member.authenticate params[:member][:mail], params[:member][:passord]

      if member.nil?
        @member_mail = params[:member][:mail]
        flash.now[:error] = "Du tastet inn feil brukernavn eller passord."
        render :new  
      else
        flash[:success] = "Du er nå logget inn."
        session[:member_id] = member.id
        redirect_to root_path
      end

    elsif !params[:user].nil?
      logger.debug "trying to login as randomUser"
      session[:member_id] = nil

      user = User.authenticate params[:user][:email], params[:user][:password]

      if user.nil?
        @user_mail = params[:user][:email]
        flash.now[:error] = "Du tastet inn feil brukernavn eller passord."
        render :new
      else
        flash[:success] = "Du er nå logget inn."
        session[:user_id] = user.id
        redirect_to root_path
      end
    end
  end
end
