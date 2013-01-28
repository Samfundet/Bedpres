# encoding: UTF-8

class ParticipationsController < ApplicationController
  filter_access_to :all

  def destroy
    @participation = Participation.where(:presentation_id => params[:presentation_id], :user_id => @current_user).first

    if @participation.destroy
      flash[:success] = "Du er nå avmeldt presentasjonen."
    else
      flash[:error] = @participation.errors.full_messages.first
    end

    redirect_to @participation.presentation
  end

  def create
    @participation = Participation.new(
      :user => @current_user, 
      :presentation_id => params[:presentation_id]
    )

    if @participation.save
      flash[:success] = "Du er nå påmeldt presentasjonen."
    else
      flash[:error] = @participation.errors.full_messages.first
    end

    redirect_to presentation_path(params[:presentation_id])
  end
end
