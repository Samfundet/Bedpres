# encoding: UTF-8

class ParticipationsController < ApplicationController
  filter_access_to :all

  def destroy
    @participation = Participation.where(:presentation_id => params[:presentation_id], :user_id => @current_user).first
    @participation.destroy
    flash[:success] = "Du er nå avmeldt presentasjonen."
    redirect_to @participation.presentation
  end

  def create
    @presentation = Presentation.find(params[:presentation_id])
    if @presentation.users.size < @presentation.guest_limit && Time.now < @presentation.presentation_date
      if @presentation.users.include? @current_user
        flash[:failure] = "Du er allerede påmeldt denne presentasjonen."
        redirect_to @presentation
      else
        @participation = Participation.new(
          :user => @current_user, 
          :presentation => @presentation
        )
        if @participation.save!
          flash[:success] = "Du er nå påmeldt presentasjonen."
          redirect_to @presentation
        else
          flash[:failure] = "Noe gikk galt."
          redirect_to @presentation
        end
      end
    else
      if Time.now >= @presentation.presentation_date
        flash[:failure] = "Denne presentasjonen er desverre begynt."
        redirect_to @presentation
      else
        flash[:failure] = "Denne presentasjonen er desverre full."
        redirect_to @presentation
      end
    end
  end
end