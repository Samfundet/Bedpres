# encoding: UTF-8

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

  def forgot_password; end

  def generate_forgot_password_email
    @email = params[:user][:email]
    user = User.find_by_email @email

    if user.nil?
      flash.now[:error] = "Den eksisterer ingen bruker med denne adressen."
      render :forgot_password

    elsif user.can_recover_password?
      hash = user.create_recovery_hash

      if PasswordRecovery.create(
          :user => user,
          :recovery_hash => hash)
        if UserMailer.forgot_password(user, hash).deliver
          flash[:success] = "En epost har blitt sendt til #{user.email} med videre instrukser."
          redirect_to root_path
        else
          flash.now[:error] = "En feil har forekommet og passordbytte har ikke blitt fullført."
          render :forgot_password
        end
      else
        flash.now[:error] = "En feil har forekommet og passordbytte har ikke blitt fullført."
        render :forgot_password
      end

    else
      flash[:error] = <<-MSG
        Du har oversteget grensen for mulige
        passordtilbakestillinger. Hvis problemet
        ikke er løst kan du sende en epost til
        mg-web@samfundet.no.
      MSG

      redirect_to root_path
    end
  end

  def reset_password
    @user = User.find params[:id]
    @hash = params[:hash]
  end

  def change_password
    @user = User.find params[:id]
    @hash = params[:hash]

    if @user.check_hash @hash
      if @user.update_attributes params[:user]
        @user.password_recoveries.destroy_all
        flash[:success] = "Passord har blitt tilbakestilt. Du kan nå logge inn med ditt nye passord."
        redirect_to login_path
      else
        render :reset_password
      end
    end
  end
end
