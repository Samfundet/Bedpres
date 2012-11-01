class UsersController < ApplicationController
  filter_access_to :all

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Velkommen, #{@user.full_name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end
  
end
