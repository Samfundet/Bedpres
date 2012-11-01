# encoding: UTF-8

class SessionsController < ApplicationController
  def new
  end

  def destroy
    session[:member_id] = nil
    redirect_to root_path
  end

  def create
    member = Member.authenticate params[:member][:mail], params[:member][:passord]

    if member.nil?
      @mail = params[:member][:mail]
      flash.now[:error] = "Du tastet inn feil brukernavn eller passord."
      render :new
    else
      flash[:success] = "Du er nå logget inn."
      session[:member_id] = member.id
      redirect_to root_path
    end
  end
end
