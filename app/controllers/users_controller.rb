class UsersController < ApplicationController
  filter_access_to :all

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      #flash[:success] = "Welcome, #{@user.name}.".html_safe
      #session[:user_id] = @user.id
      redirect_to root_path #@user
    else
      #flash.now[:failure] = "<span class='black'>Invalid</span> user data.".html_safe
      render :new
    end
  end
end
