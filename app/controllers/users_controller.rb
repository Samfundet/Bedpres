# encoding: UTF-8

class UsersController < ApplicationController
  include PasswordResetHelper
  
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
    begin
      @user.verify!(params[:hash])
      flash[:success] = "#{@user.email} er nå validert."
    rescue HashMismatchError
      flash[:failure] = "Verifikasjonslenken stemmer ikke overens med denne brukeren"
    rescue Exception
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
    else
      begin
        user.forgot_password!
        flash[:success] = "En epost har blitt sendt til #{user.email} med videre instrukser."
        redirect_to root_path
      rescue MaxAttemptsReachedError
        flash.now[:error] = <<-MSG
          Du har oversteget grensen for mulige
          passordtilbakestillinger. Hvis problemet
          ikke er løst kan du sende en epost til
          mg-web@samfundet.no.
        MSG
        render :forgot_password
      rescue Exception
        flash.now[:error] = "En feil har forekommet og passordbytte har ikke blitt fullført."
        render :forgot_password
      end
    end
  end

  def reset_password
    @user = User.find params[:id]
    @hash = params[:hash]
  end

  def change_password
    @user = User.find params[:id]
    @hash = params[:hash]

    begin
      @user.reset_password!(@hash, params[:user])
      flash[:success] = "Passordet har blitt endret. Du kan nå logge inn med ditt nye passord."
      redirect_to login_path
    rescue HashMismatchError
      flash.now[:error] = "Passordet du skrev inn stemmer ikke. Passordet har ikke blitt endret."
      render :reset_password
    rescue Exception
      flash.now[:error] = "Noe gikk galt. Passordet har ikke blitt endret."
      render :reset_password
    end
  end
  
  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update_attributes(params[:user])
      flash[:success] = "Brukeren er oppdatert."
      redirect_to root_path
    else
      flash.now[:error] = "Brukeren ble ikke oppdatert"
      render :edit
    end
  end
end
