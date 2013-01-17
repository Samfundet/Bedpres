# encoding: UTF-8

class UsersController < ApplicationController
  filter_access_to :all
  filter_access_to [:edit, :update], :attribute_check => true

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "En epost har blitt sendt til #{@user.email} med en lenke for å aktivere kontoen din."
      redirect_to login_path
    else
      render :new
    end
  end

  def verify_account
    @user = User.find(params[:id])
    if @user
      if @user.create_verification_hash == params[:hash]
        @user.verified = true
        @user.save
        flash[:success] = "#{@user.email} er nå validert."
      else
        flash[:failure] = "Fant ingen fyrstikk."
      end
    else
      flash[:failure] = "All work and no play makes johnny a dull boy."
    end
    redirect_to root_path
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

  
  def edit
    @user = User.find params[:id]
  end


  def update
    @user = User.find params[:id]

    password_should_change = !(params[:user][:password].blank? &&
                               params[:user][:password_confirmation].blank?)

    if password_should_change
      user_pwd_check = User.authenticate(@user.email, params[:user][:old_password])
      if user_pwd_check.nil?
        flash[:error] = "Du tastet inn feil passord."
        render :edit
        return
      end
    end

    unless password_should_change
      [:old_password, :password, :password_confirmation].each do |key|
        params[:user].delete(key)
      end
    end

    if @user.update_attributes(params[:user])
      flash[:success] = "Brukeren er oppdatert."
      redirect_to root_path
    else
      flash.now[:error] = "Brukeren ble ikke oppdatert"
      render :edit
    end
  end
end
